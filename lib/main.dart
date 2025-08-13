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

  // Future<void> checkForUpdate() async {
  //   // Only check for updates on Android
  //   if (!Platform.isAndroid) return;

  //   try {
  //     final info = await InAppUpdate.checkForUpdate();
  //     _updateInfo = info;

  //     if (_updateInfo?.updateAvailability ==
  //         UpdateAvailability.updateAvailable) {
  //       await InAppUpdate.performImmediateUpdate();
  //     }
  //   } catch (e) {
  //     log('App update error: $e');
  //   }
  // }

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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     checkForUpdate();
    //   });
    // });
  }

  Future<void> _autoSelectSanjeewaniSchool() async {
    try {
      // Check if school is already selected
      final schoolDetails = LocalStorageMethods.getSchoolDetails();

      if (schoolDetails == null || schoolDetails["logo"] == "") {
        log('No school selected, auto-selecting Sanjeewani...');

        // Make API call to search for Sanjeewani school
        // You'll need to implement this method in your ApiMethods class
        final response = await _searchSanjeewaniSchool();

        if (response != null) {
          // Save Sanjeewani school details
          await LocalStorageMethods.saveSchoolDetails(
            response['domain_name'] ?? '',
            response['logo'] ?? '',
            response['name'] ?? '',
          );
          log('Sanjeewani School auto-selected successfully');
        }
      }

      // Determine initial route after school selection
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

  Future<Map<String, dynamic>?> _searchSanjeewaniSchool() async {
    try {
      // Based on your logs, make the API call to search for Sanjeewani
      // You might need to create this method in ApiMethods or use existing one
      final response =
          await ApiMethods.searchSchools(name: "sanjeewani", page: 1);

      if (response is SuccessResponse && response.data["data"] != null) {
        final schools = response.data["data"] as List;
        if (schools.isNotEmpty) {
          // Return the first Sanjeewani school found
          return schools.first;
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
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.red,
                ),
                // SizedBox(height: 20),
                // Text('Loading Sanjeewani School...'),
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

    // Check school details
    if (schoolDetails == null || schoolDetails["logo"] == "") {
      return AppPages.selectSchool;
    }

    // Check user details
    if (userDetails == null || userDetails["token"] == "") {
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
