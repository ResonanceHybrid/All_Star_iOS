import 'package:all_star_learning/config/translations/localization_service.dart';
import 'package:all_star_learning/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// todo configure text family and size
class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType =>
      LocalizationService.supportedLanguagesFontsFamilies[
          LocalStorageMethods.getCurrentLocal().languageCode]!;

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // caption text font
  static TextStyle get captionTextStyle => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => 20.sp;

  // headlines font size
  static double get headlineLargeTextSize => 20.sp;
  static double get headlineMediumTextSize => 18.sp;
  static double get headlineSmallTextSize => 16.sp;

  //title font size
  static double get titleLargeTextSize => 16.sp;
  static double get titleMediumTextSize => 15.sp;
  static double get titleSmallTextSize => 14.sp;

  //body font size
  static double get bodyLargeTextSize => 13.sp;
  static double get bodyMediumTextSize => 12.sp;
  static double get bodySmallTextSize => 11.sp;

  //button font size
  static double get buttonTextSize => 16.sp;

  //caption font size
  static double get captionTextSize => 13.sp;

  //chip font size
  static double get chipTextSize => 10.sp;
}
