import 'package:all_star_learning/config/translations/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageMethods {
  // prevent making instance
  LocalStorageMethods._();

  // get storage
  static final GetStorage storage = GetStorage();

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _credentialsKey = 'credentials';
  static const String _userDetails = 'userDetails';
  static const String _schoolDetailsKey = 'schoolDetails';

  /// init get storage services

  static init() async {
    await GetStorage.init();
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      storage.write(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      storage.read(_lightThemeKey) ??
      true; // todo set the default theme (true for light, false for dark)

//save id pw
  static Future<void> saveCredentials(
          bool rememberMe, String email, String password) =>
      storage.write(_credentialsKey, {
        "rememberMe": rememberMe,
        "email": email,
        "password": password,
      });

  //save school details
  static Future<void> saveSchoolDetails(
          String domain, String logo, String name) =>
      storage.write(_schoolDetailsKey, {
        "domain_name": domain,
        "logo": logo,
        "name": name,
      });
  //get school details

  static getSchoolDetails() => storage.read(_schoolDetailsKey);

//removeschool details
  static removeSchoolDetails() => storage.remove(_schoolDetailsKey);

//get id pw

  static getCredentials() => storage.read(_credentialsKey);

  //get id pw
  static removeCredentials() => storage.remove(_credentialsKey);

  //save id pw
  static Future<void> saveUserDetails(Map userDetails) =>
      storage.write(_userDetails, userDetails);

//get id pw
  static getUserDetails() => storage.read(_userDetails);

  // remove school details

  static removeUserDetails() => storage.remove(_userDetails);

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) =>
      storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      storage.write(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => storage.read(_fcmTokenKey);

  /// clear all data from shared pref
  static Future<void> clear(key) async => await storage.remove(key);

  // set user details
}
