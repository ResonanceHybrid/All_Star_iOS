import 'dart:developer';
import 'dart:io';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/fcm_helper.dart';
import 'package:all_star_learning/firebase_options.dart';
import 'package:all_star_learning/new/core/bloc/bloc_providers.dart';
import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optimize system UI overlay style early
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Firebase first (required for some storage operations)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log('Firebase initialization error: $e');
  }

  // Initialize local storage after Firebase
  try {
    await LocalStorageMethods.init();
  } catch (e) {
    log('LocalStorage initialization error: $e');
    // Continue without local storage if it fails
  }

  await setUpLocator();

  FcmHelper.initFcm();

  runApp(
    MultiBlocProvider(
      providers: BlocProvidersList.blocProvidersList,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? initialRoute;
  bool isLoading = true;

  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    // Only check for updates on Android
    if (!Platform.isAndroid) return;

    try {
      final info = await InAppUpdate.checkForUpdate();
      _updateInfo = info;

      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      log('App update error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    // Set orientation early in initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Auto-select Sanjeewani School
    _autoSelectSanjeewaniSchool();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        checkForUpdate();
      });
    });
  }

  Future<void> _autoSelectSanjeewaniSchool() async {
    try {
      // Check if school is already selected
      final schoolDetails = LocalStorageMethods.getSchoolDetails();

      if (schoolDetails == null ||
          schoolDetails["logo"] == null ||
          schoolDetails["logo"] == "") {
        log('No school selected, auto-selecting Sanjeewani...');

        // Make API call to search for Sanjeewani school
        final response = await _searchSanjeewaniSchool();

        if (response != null) {
          // Save Sanjeewani school details with proper mapping
          await LocalStorageMethods.saveSchoolDetails(
            'sanjeewani', // domain_name - you might need to adjust this
            response['logo'] ?? '',
            response['school_name'] ??
                response['school_display_name'] ??
                'Sanjeewani School',
          );
          log('Sanjeewani School auto-selected successfully');
        }
      }

      // Check session timeout after school selection
      _checkSessionTimeout();

      // Determine initial route after school selection and session check
      setState(() {
        initialRoute = _getInitialRoute();
        isLoading = false;
      });
    } catch (e) {
      log('Error auto-selecting Sanjeewani: $e');
      setState(() {
        initialRoute = AppPages.selectSchool;
        isLoading = false;
      });
    }
  }

  // Add session timeout check here
  void _checkSessionTimeout() {
    try {
      var loginTime = LocalStorageMethods.getLoginTime();
      if (loginTime != null) {
        DateTime loginDateTime = DateTime.parse(loginTime);
        DateTime currentTime = DateTime.now();
        Duration difference = currentTime.difference(loginDateTime);

        if (difference.inHours >= 24) {
          log('Session expired, clearing user data');
          LocalStorageMethods.removeUserDetails();
          LocalStorageMethods.removeLoginTime();
          LocalStorageMethods.removeCredentials();
        }
      }
    } catch (e) {
      log('Error checking session timeout: $e');
    }
  }

  Future<Map<String, dynamic>?> _searchSanjeewaniSchool() async {
    try {
      final response =
          await ApiMethods.searchSchools(name: "sanjeewani", page: 1);

      if (response is SuccessResponse && response.data["success"] == true) {
        final schools = response.data["data"] as List;
        if (schools.isNotEmpty) {
          // Return the first school found
          return schools.first as Map<String, dynamic>;
        }
      }
    } catch (e) {
      log('Error searching for Sanjeewani school: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while auto-selecting school
    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.red,
                ),
                SizedBox(height: 20),
                Text(
                  'Loading Sanjeewani School...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "Sanjeewani School",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            bool themeIsLight = LocalStorageMethods.getThemeIsLight();
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight).copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
                splashFactory: InkSplash.splashFactory,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              ),
            );
          },
          initialRoute: initialRoute ?? AppPages.selectSchool,
          getPages: AppPages.routes,
          locale: LocalStorageMethods.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
          enableLog: false,
          logWriterCallback: (text, {isError = false}) {
            if (isError) {
              log(text);
            }
          },
        );
      },
    );
  }

  String _getInitialRoute() {
    final schoolDetails = LocalStorageMethods.getSchoolDetails();
    final userDetails = LocalStorageMethods.getUserDetails();

    // Check school details first
    if (schoolDetails == null ||
        schoolDetails["logo"] == null ||
        schoolDetails["logo"] == "") {
      return AppPages.selectSchool;
    }

    // Check user details and token validity
    if (userDetails == null ||
        userDetails["token"] == null ||
        userDetails["token"] == "") {
      return AppPages.login;
    }

    // Route based on user role
    final userRole = userDetails["data"]?["role"];
    switch (userRole) {
      case "student":
        return AppPages.studentNavigation;
      case "teacher":
        return AppPages.teacherNavigation;
      default:
        return AppPages.login;
    }
  }
}
