import 'dart:developer';

import 'package:all_star_learning/routes/app_pages.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AwesomeNotificationsHelper {
  AwesomeNotificationsHelper._();

  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  static init() async {
    await _initNotification();
    await awesomeNotifications.requestPermissionToSendNotifications();
    listenToActionButtons();
  }

  static listenToActionButtons() {
    awesomeNotifications.setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  static _initNotification() async {
    await awesomeNotifications.initialize(
      "resource://drawable/launch_image",
      [
        NotificationChannel(
            channelGroupKey: NotificationChannels.allStarChannelKey,
            channelKey: NotificationChannels.allStarChannelKey,
            channelName: NotificationChannels.allStarChannelKey,
            groupKey: NotificationChannels.allStarChannelKey,
            channelDescription: NotificationChannels.allStarChannelKey,
            defaultColor: Colors.green,
            ledColor: Colors.white,
            channelShowBadge: true,
            playSound: true,
            importance: NotificationImportance.Max)
      ],
    );
  }

  static int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  //display notification for user with sound
  static showNotification(
      {required String title,
      required String body,
      Map<String, String>? payload,
      String? bigPicture}) async {
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      } else {
        try {
          bigPicture == ""
              ? awesomeNotifications.createNotification(
                  content: NotificationContent(
                    id: _createUniqueId(),
                    channelKey: NotificationChannels.allStarChannelKey,
                    title: title,
                    body: body,
                    notificationLayout: NotificationLayout.BigText,
                    payload: payload,
                  ),
                )
              : awesomeNotifications.createNotification(
                  content: NotificationContent(
                    id: _createUniqueId(),
                    channelKey: NotificationChannels.allStarChannelKey,
                    title: title,
                    body: body,
                    bigPicture: bigPicture,
                    notificationLayout: NotificationLayout.BigPicture,
                    payload: payload,
                  ),
                );
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    AwesomeNotifications().decrementGlobalBadgeCounter();

    Map<String, String?>? payload = receivedAction.payload;

    log("payload: $payload");

    String routeToGetTo = payload?['redirect_url'] ?? "";
    if (routeToGetTo == "notice") {
      Get.key.currentState?.pushNamed(AppPages.teacherNotices, arguments: true);
    } else {}
  }
}

class NotificationChannels {
  static String get allStarChannelKey => "AllStar";
}
