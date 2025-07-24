import 'dart:developer';
import 'package:all_star_learning/Utils/fcm_helper.dart';
import 'package:all_star_learning/firebase_options.dart';
import 'package:all_star_learning/new/core/bloc/bloc_providers.dart';
import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/local_storage.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/school_list_model.dart';
import 'package:all_star_learning/Resources/initial_api_method.dart';
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

    // Auto-set Sanjeewani School from API if no school is selected
    await _setSanjeewaniSchoolFromAPI();
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

// Function to fetch and set Sanjeewani School from API
Future<void> _setSanjeewaniSchoolFromAPI() async {
  try {
    final schoolDetails = LocalStorageMethods.getSchoolDetails();

    // If no school is selected, fetch and set Sanjeewani School
    if (schoolDetails == null ||
        schoolDetails["domainName"] == null ||
        schoolDetails["domainName"] == "" ||
        schoolDetails["name"] == null ||
        schoolDetails["name"] == "") {
      log('No school selected, fetching Sanjeewani School from API...');

      // Search for Sanjeewani School using the API
      BaseResponse response = await InitialApi.getSchoolList(
          schoolName: "Sanjeewani", // Search for Sanjeewani School
          page: 1);

      if (response is SuccessResponse) {
        SchoolListModel schoolListModel = response.data as SchoolListModel;

        if (schoolListModel.data != null && schoolListModel.data!.isNotEmpty) {
          // Find Sanjeewani School in the results
          School? sanjeewaniSchool;

          for (School school in schoolListModel.data!) {
            // Check if school name contains "Sanjeewani" (case insensitive)
            if (school.name != null &&
                school.name!.toLowerCase().contains("sanjeewani")) {
              sanjeewaniSchool = school;
              break;
            }
          }

          if (sanjeewaniSchool != null) {
            // Save Sanjeewani School details from API response
            await LocalStorageMethods.saveSchoolDetails(
              sanjeewaniSchool.domainName ?? "",
              sanjeewaniSchool.logo ?? "",
              sanjeewaniSchool.name ?? "",
            );

            log('Sanjeewani School set successfully from API: ${sanjeewaniSchool.name}');
          } else {
            log('Sanjeewani School not found in API response');
          }
        } else {
          log('No schools found in API response');
        }
      } else {
        log('API call failed: ${response.message}');
      }
    } else {
      log('School already selected: ${schoolDetails["name"]}');
    }
  } catch (e) {
    log('Error setting Sanjeewani School from API: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
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

    // Check for updates after a brief delay to avoid interference with app startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        checkForUpdate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "AllStar EMS",
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
          initialRoute: _getInitialRoute(),
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

    // Check if school is set (should be Sanjeewani now)
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
