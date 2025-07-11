import 'package:all_star_learning/Pages/TeacherPages/Calendar/teacher_common_calendar.dart';
import 'package:all_star_learning/Pages/TeacherPages/Homework/home_work_list_page.dart';
import 'package:all_star_learning/Pages/TeacherPages/Teacher%20Notice/teacher_notices.dart';
import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/teacher_home_page.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/theme/light_theme_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../new/features/qr/presentation/view/qr_view.dart';

class TeacherNavigationPage extends StatefulWidget {
  const TeacherNavigationPage({super.key});

  @override
  State<TeacherNavigationPage> createState() => _TeacherNavigationPageState();
}

class _TeacherNavigationPageState extends State<TeacherNavigationPage> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  int _selectedIndex = 0;
  final List<Widget> pages = <Widget>[
    const TeacherHomePage(),
    const TeacherCommonCalendarPage(),
    const HomeworkListPage(
      fromNav: true,
    ),
    const TeacherNoticesPage(
      isFromNotification: false,
    ),
    const QrView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Map userDetails = {};
  getUserDetails() async {
    var details = LocalStorageMethods.getUserDetails();
    if (details != null) {
      userDetails = details;

      if (userDetails["data"]["first_time_login"] == true) {
        Future.delayed(Duration.zero, () {
          Get.offAllNamed(AppPages.changePasswordFirstTime);
        });
      }
    }
    setState(() {});
  }

  DateTime preBackPress = DateTime.now();
  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool hasPopped) async {
        final timegap = DateTime.now().difference(preBackPress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackPress = DateTime.now();
        if (cantExit) {
          //show snackbar
          cm.showSnackBar(context, "Swipe back again to exit", Colors.red);
          return;
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Center(child: pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: AppColors.kGreyColor,
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.sp,
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          height: 66.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: bottomNavBarItems(0, 'Home', kHomeAltNavIcon),
                ),
                Expanded(
                  flex: 3,
                  child: bottomNavBarItems(1, 'Calender', kCalenderNavIcon),
                ),
                Expanded(
                  flex: 3,
                  child: bottomNavBarItems(2, 'HomeWork', kHomeworkIcon),
                ),
                Expanded(
                  flex: 1,
                  child: bottomNavBarItems(3, 'Notice', kNoticeNavIcon),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 68,
          width: 68,
          child: FloatingActionButton(
            shape: const StadiumBorder(),
            onPressed: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
            tooltip: 'Qr',
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: AppColors.kGreyColor,
            child: Image.asset(
              kQrIcon,
              color: LightThemeColors.primaryColor,
              height: 30.sp,
              width: 30.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavBarItems(int index, String name, String imageUrl) {
    return InkResponse(
      onTap: () => _onItemTapped(index),
      splashColor: LightThemeColors.primaryColor.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 23,
              // width: 23,
              fit: BoxFit.cover,
              color: _selectedIndex == index
                ? LightThemeColors.primaryColor
                : Colors.grey,
            ),
            SizedBox(height: 5.h),
            Text(
              name,
              style: TextStyle(
                color: _selectedIndex == index
                    ? LightThemeColors.primaryColor
                    : Colors.grey.shade700,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
