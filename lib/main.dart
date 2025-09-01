import 'dart:developer';
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
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log('Firebase initialization error: $e');
  }

  try {
    await LocalStorageMethods.init();
  } catch (e) {
    log('LocalStorage initialization error: $e');
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
  @override
  void initState() {
    super.initState();

    // Set orientation early in initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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

          // Optimize default transitions to reduce animation conflicts
          // defaultTransition: Transition.fade,
          // transitionDuration: const Duration(milliseconds: 200),

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

    if (schoolDetails == null || schoolDetails["logo"] == "") {
      return AppPages.selectSchool;
    }

    if (userDetails == null || userDetails["token"] == "") {
      return AppPages.login;
    }

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
