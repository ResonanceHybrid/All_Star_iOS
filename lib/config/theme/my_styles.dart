import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_fonts.dart';

class MyStyles {
  ///icons theme
  static IconThemeData getIconTheme({required bool isLightTheme}) => IconThemeData(
        color: isLightTheme ? LightThemeColors.iconColor : const Color.fromARGB(255, 249, 249, 249),
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme({required bool isLightTheme}) => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: getTextTheme(isLightTheme: isLightTheme).headlineSmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        //    getTextTheme(isLightTheme: isLightTheme).bodyLarge!.copyWith(
        //   color: Colors.white,
        //   fontSize: MyFonts.appBarTittleSize,
        //   fontWeight: FontWeight.bold,
        // ),

        iconTheme: IconThemeData(color: isLightTheme ? LightThemeColors.appBarIconsColor : DarkThemeColors.appBarIconsColor),
        backgroundColor: isLightTheme ? LightThemeColors.appBarColor : DarkThemeColors.appbarColor,
      );

  ///text theme
  static TextTheme getTextTheme({required bool isLightTheme}) => TextTheme(
        headlineLarge: MyFonts.headlineTextStyle
            .copyWith(fontSize: MyFonts.headlineLargeTextSize, fontWeight: FontWeight.bold, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        headlineMedium: MyFonts.headlineTextStyle
            .copyWith(fontSize: MyFonts.headlineMediumTextSize, fontWeight: FontWeight.bold, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        headlineSmall: MyFonts.headlineTextStyle
            .copyWith(fontSize: MyFonts.headlineSmallTextSize, fontWeight: FontWeight.bold, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        titleLarge: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.titleLargeTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        titleMedium: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.titleMediumTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        titleSmall: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.titleSmallTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        labelLarge: MyFonts.buttonTextStyle.copyWith(
          fontSize: MyFonts.buttonTextSize,
        ),
        bodyLarge: MyFonts.bodyTextStyle.copyWith(fontSize: MyFonts.bodyLargeTextSize, color: isLightTheme ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor),
        bodyMedium: MyFonts.bodyTextStyle.copyWith(fontSize: MyFonts.bodyMediumTextSize, color: isLightTheme ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor),
        bodySmall: TextStyle(color: isLightTheme ? LightThemeColors.captionTextColor : DarkThemeColors.captionTextColor, fontSize: MyFonts.bodySmallTextSize),
        displayLarge: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.bodyLargeTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        displayMedium: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.bodyMediumTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
        displaySmall: MyFonts.headlineTextStyle.copyWith(fontSize: MyFonts.bodySmallTextSize, color: isLightTheme ? LightThemeColors.headlinesTextColor : DarkThemeColors.headlinesTextColor),
      );

  static ChipThemeData getChipTheme({required bool isLightTheme}) {
    return ChipThemeData(
      backgroundColor: isLightTheme ? LightThemeColors.chipBackground : DarkThemeColors.chipBackground,
      brightness: Brightness.light,
      labelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      secondaryLabelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      selectedColor: Colors.black,
      disabledColor: Colors.green,
      padding: const EdgeInsets.all(5),
      secondarySelectedColor: Colors.purple,
    );
  }

  ///Chips text style
  static TextStyle getChipTextStyle({required bool isLightTheme}) {
    return MyFonts.chipTextStyle.copyWith(
      fontSize: MyFonts.chipTextSize,
      color: isLightTheme ? LightThemeColors.chipTextColor : DarkThemeColors.chipTextColor,
    );
  }

  // elevated button text style
  static MaterialStateProperty<TextStyle?>? getElevatedButtonTextStyle(bool isLightTheme, {bool isBold = true, double? fontSize}) {
    return MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              color: isLightTheme ? LightThemeColors.buttonTextColor : DarkThemeColors.buttonTextColor);
        } else if (states.contains(MaterialState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLightTheme ? LightThemeColors.buttonDisabledTextColor : DarkThemeColors.buttonDisabledTextColor);
        }
        return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isLightTheme ? LightThemeColors.buttonTextColor : DarkThemeColors.buttonTextColor); // Use the component's default.
      },
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme({required bool isLightTheme}) => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              //side: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: getElevatedButtonTextStyle(isLightTheme),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return isLightTheme ? LightThemeColors.buttonColor.withOpacity(0.5) : DarkThemeColors.buttonColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return isLightTheme ? LightThemeColors.buttonDisabledColor : DarkThemeColors.buttonDisabledColor;
              }
              return isLightTheme ? LightThemeColors.buttonColor : DarkThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );
}
