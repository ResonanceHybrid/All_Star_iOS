import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/theme/my_theme.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
              if (_isLoggingOut)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text("Logging out...",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                )
              else
                widgetListTile(
                  "Logout",
                  kLogoutIcon,
                  () => _performLogout(),
                  "",
                ),
            ],
          ),
        ),
      ),
    );
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

  Future<void> _performLogout() async {
    // Prevent multiple taps
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      // Only remove local data - NO Firebase operations
      LocalStorageMethods.removeUserDetails();

      // Minimal delay
      await Future.delayed(Duration(milliseconds: 300));

      // Navigate immediately
      Get.offAllNamed(AppPages.login);
    } catch (e) {
      print("Logout error: $e");
      Get.offAllNamed(AppPages.login);
    }
  }
}
