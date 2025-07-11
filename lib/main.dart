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
import 'package:in_app_update/in_app_update.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageMethods.init();
  await setUpLocator();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    //
  }

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
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        // ignore: body_might_complete_normally_catch_error
        InAppUpdate.performImmediateUpdate().catchError((e) {
          log(e.toString());
        });
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  @override
  void initState() {
    checkForUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
              data: MyTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              ),
            );
          },
          initialRoute: LocalStorageMethods.getSchoolDetails() == null ||
                  LocalStorageMethods.getSchoolDetails()?["logo"] == ""
              ? AppPages.selectSchool
              : LocalStorageMethods.getUserDetails() == null ||
                      LocalStorageMethods.getUserDetails()["token"] == ""
                  ? AppPages.login
                  : LocalStorageMethods.getUserDetails()["data"]["role"] ==
                          "student"
                      ? AppPages.studentNavigation
                      : LocalStorageMethods.getUserDetails()["data"]["role"] ==
                              "teacher"
                          ? AppPages.teacherNavigation
                          : AppPages.login,
          getPages: AppPages.routes,
          locale: LocalStorageMethods.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
        );
      },
    );
  }
}
