import 'package:all_star_learning/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static getThemeData({required bool isLight}) {
    // static const Color appBackGroundColor = Color(0xFFf5f9fb);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: isLight ? LightThemeColors.scaffoldBackgroundColor : DarkThemeColors.scaffoldBackgroundColor,
      bottomAppBarTheme: BottomAppBarTheme(
        color: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      canvasColor: isLight ? const Color.fromARGB(255, 225, 229, 236) : DarkThemeColors.canvasColor,
      primaryColor: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
      // color contrast (if the theme is dark text should be white for example)
      brightness: isLight ? Brightness.light : Brightness.dark,
      // card widget background color
      cardColor: isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(
            isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
          ),
        ),
      ),
      primaryIconTheme: IconThemeData(
        color: isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(
            isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
        suffixIconColor: isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
        iconColor: isLight ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
        labelStyle: TextStyle(
          color: isLight ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor,
        ),
        hintStyle: TextStyle(
          color: isLight ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor,
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
      ),
      // hint text color
      hintColor: isLight ? LightThemeColors.hintTextColor : DarkThemeColors.hintTextColor,
      // divider color
      dividerColor: isLight ? LightThemeColors.dividerColor : DarkThemeColors.dividerColor,

      // progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
      ),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),
     

      // elevated button theme

      elevatedButtonTheme: MyStyles.getElevatedButtonTheme(isLightTheme: isLight),
      dividerTheme: DividerThemeData(color: isLight ? LightThemeColors.dividerColor : DarkThemeColors.dividerColor, thickness: 1, space: 0, indent: 0, endIndent: 0),

      // text theme
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),

      // chip theme
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),

      // icon theme
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),

      colorScheme: ColorScheme.fromSwatch()
          .copyWith(brightness: isLight ? Brightness.light : Brightness.dark, secondary: isLight ? LightThemeColors.accentColor : DarkThemeColors.accentColor)
          .copyWith(background: isLight ? LightThemeColors.backgroundColor : DarkThemeColors.backgroundColor),
    );
  }

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)
  static changeTheme() {
    bool isLightTheme = LocalStorageMethods.getThemeIsLight();
    LocalStorageMethods.setThemeIsLight(!isLightTheme);
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  bool get getThemeIsLight => LocalStorageMethods.getThemeIsLight();
}
