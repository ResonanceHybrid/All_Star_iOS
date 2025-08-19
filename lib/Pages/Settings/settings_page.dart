import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/theme/my_theme.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  CustomMethods cm = CustomMethods();
  bool notificationsEnabled = true;
  bool _isLoggingOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 5),
              ListTile(
                leading: Image.asset(
                  kChangeThemeIcon,
                  height: 30.sp,
                ),
                title: Text('Change Theme',
                    style: Theme.of(context).textTheme.bodyLarge),
                onTap: () => MyTheme.changeTheme(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(
                color: AppColors.kGreyColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("GENERAl",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 5),
              // widgetListTile("Send Notification", kNotificationIcon, () async {
              //   cm.loadingAlertDialog();
              //   BaseResponse data = await ApiMethods.pushNotificationUsingFcm(
              //       title: "Hello", description: "test");
              //   if (data is SuccessResponse) {
              //     if (!mounted) return;
              //     Get.back();
              //     cm.showSnackBar(
              //         context,
              //         data.message ?? "Notification Send Successfully",
              //         Colors.green);
              //   } else if (data is ErrorResponse) {
              //     if (!mounted) return;
              //     Get.back();
              //     cm.showSnackBar(context,
              //         data.message ?? "Something went wrong", Colors.red);
              //   }
              // }, "Privacy. Security, Language"),

              // widgetListTile("Account Settings", kSettingsIcon, () {}, "Privacy. Security, Language"),
              const SizedBox(height: 5),
              widgetListTile(
                "Notification",
                kNotificationIcon,
                () {
                  Get.toNamed(AppPages.notificationPage);
                },
                "News Letter, App Updates",
              ),
              const SizedBox(height: 5),
              widgetListTile("Enable notification", kEnableNotificationIcon,
                  () {
                setState(() {
                  notificationsEnabled = !notificationsEnabled;
                });
              }, "",
                  trailing: Switch.adaptive(
                    inactiveTrackColor: AppColors.colorsGrey300,
                    activeTrackColor: AppColors.mainColor,
                    value: notificationsEnabled,
                    onChanged: (bool val) {
                      setState(() {
                        notificationsEnabled = val;
                      });
                    },
                  )),
              const SizedBox(height: 5),
              widgetListTile(
                "Edit profile",
                kEditProfileIcon,
                () {
                  Get.toNamed(AppPages.editProfile);
                },
                "",
              ),
              const SizedBox(height: 5),
              widgetListTile(
                "Change password",
                kChangePasswordIcon,
                () {
                  Get.toNamed(AppPages.changePassword);
                },
                "",
              ),

              const SizedBox(height: 5),
              widgetListTile(
                "Logout",
                kLogoutIcon,
                () async {
                  _performLogout();
                },
                "",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogout() async {
    // Prevent multiple logout calls
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    // Show loading dialog
    CustomMethods().loadingAlertDialog();

    try {
      // 1. Clear all local storage data (most critical)
      await LocalStorageMethods.removeUserDetails();
      await LocalStorageMethods.removeLoginTime(); // Clear login time
      await LocalStorageMethods.removeCredentials(); // Clear saved credentials

      // 2. Start Firebase cleanup in background (non-blocking)
      _performFirebaseCleanup();

      // 3. Brief delay for visual feedback
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      print("Logout error: $e");
    } finally {
      // 4. Always ensure dialog is closed
      _closeLoadingDialog();

      // 5. Navigate to login with safety measures
      await _safeNavigateToLogin();

      _isLoggingOut = false;
    }
  }

  void _closeLoadingDialog() {
    try {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    } catch (e) {
      print("Error closing dialog: $e");
      // Try alternative dialog closing
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (e2) {
        print("Alternative dialog close failed: $e2");
      }
    }
  }

  Future<void> _safeNavigateToLogin() async {
    try {
      // Clear any existing routes and navigate to login
      Get.offAllNamed(AppPages.login);
    } catch (e) {
      print("Primary navigation failed: $e");

      // Fallback navigation
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppPages.login,
              (route) => false,
            );
          }
        });
      } catch (e2) {
        print("Fallback navigation failed: $e2");
      }
    }
  }

  void _performFirebaseCleanup() {
    // Run Firebase cleanup in background without awaiting
    CustomMethods().removeSubscriptionAndFirebaseToken().timeout(
      const Duration(seconds: 8),
      onTimeout: () {
        print("Firebase cleanup timed out - continuing in background");
        return null;
      },
    ).catchError((error) {
      print("Firebase cleanup error: $error");
      // Error is logged but doesn't affect logout flow
    });
  }

  widgetListTile(String title, String icon, Function()? onTap, String? subTitle,
      {Widget? trailing}) {
    return ListTile(
      leading: Image.asset(
        icon,
        height: 30.sp,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: subTitle != "" ? Text(subTitle!) : null,
      onTap: onTap,
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
          ),
    );
  }
}
