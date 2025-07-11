import 'dart:developer';

import 'package:all_star_learning/Utils/awesome_notifications_helper.dart';
import 'package:all_star_learning/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class FcmHelper {
  // prevent making instance
  FcmHelper._();

  // FCM Messaging
  static late FirebaseMessaging messaging;

  /// this function will initialize firebase and fcm instance
  static Future<void> initFcm() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AwesomeNotificationsHelper.init();
      messaging = FirebaseMessaging.instance;
      await _setupFcmNotificationSettings();
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
    } catch (error) {
      Logger().e(error);
    }
  }

  ///handle fcm notification settings (sound,badge..etc)
  static Future<void> _setupFcmNotificationSettings() async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //NotificationSettings settings
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    handleNotifications(payload: message.data);
  }

  //handle fcm notification when app is open
  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    handleNotifications(payload: message.data);
  }

  static handleNotifications({required Map<String, dynamic> payload}) async {
    log("FCM Payload: $payload");
    if (payload["type"] == "AllStar") {
      await AwesomeNotificationsHelper.showNotification(
        title: payload["title"] ?? "",
        body: payload["description"] ?? "",
        bigPicture: payload["imageUrl"] ?? "",
        payload: Map<String, String>.from(payload),
      );
    }
  }
}
