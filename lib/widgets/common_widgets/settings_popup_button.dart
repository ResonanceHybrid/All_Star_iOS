import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/custom_methods.dart';
import '../../Utils/local_storage.dart';
import '../../config/theme/app_static_colors.dart';
import '../../routes/app_pages.dart';

class SettingsPopupButton extends StatefulWidget {
  final bool showBackground;
  const SettingsPopupButton({super.key, this.showBackground = true});

  @override
  State<SettingsPopupButton> createState() => _SettingsPopupButtonState();
}

class _SettingsPopupButtonState extends State<SettingsPopupButton> {
  late final bool _showBackground;
  final cm = CustomMethods();

  @override
  void initState() {
    super.initState();
    _showBackground = widget.showBackground;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: isLight && !_showBackground
          ? Colors.black 
          : Colors.white,
      ),
      onSelected: (value) {},
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Future.delayed(Duration.zero, () {
                Get.toNamed(AppPages.settings);
              });
            },
            value: '/settings',
            child: Row(
              children: [
                const Icon(
                  Icons.settings,
                  color: AppColors.mainColor,
                ),
                SizedBox(width: 5.sp),
                const Text("Settings"),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              Future.delayed(Duration.zero, () async {
                cm.loadingAlertDialog();
                await cm.removeSubscriptionAndFirebaseToken();
                LocalStorageMethods.removeUserDetails();
                Get.offAllNamed(AppPages.login);
              });
            },
            value: '/hello',
            child: Row(
              children: [
                const Icon(Icons.logout, color: AppColors.mainColor),
                SizedBox(width: 5.sp),
                const Text("Logout"),
              ],
            ),
          ),
        ];
      },
    );
  }
}