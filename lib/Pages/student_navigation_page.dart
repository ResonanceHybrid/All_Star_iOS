import 'package:all_star_learning/Pages/StudentPages/Calender/student_common_calendar.dart';
import 'package:all_star_learning/Pages/StudentPages/StudentHome/student_home_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Homework/homework_page.dart';
import 'package:all_star_learning/Pages/StudentPages/Notice/student_notice_page.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/light_theme_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentNavigationPage extends StatefulWidget {
  const StudentNavigationPage({super.key});

  @override
  State<StudentNavigationPage> createState() => _StudentNavigationPageState();
}

class _StudentNavigationPageState extends State<StudentNavigationPage> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  int _selectedIndex = 0;
  final List<Widget> pages = <Widget>[
    const HomePage(),
    const StudentCommonCalendarPage(),
    const HomeworkPage(),
    const StudentNoticePage(
      isFromNotification: false,
    ),
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.sp,
          padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(bottom: 16.0),
          height: 72.sp,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Theme.of(context).highlightColor,
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: bottomNavBarItems(0, 'Home', kHomeNavIcon),
                ),
                Expanded(
                  child: bottomNavBarItems(1, 'Calender', kCalenderNavIcon),
                ),
                Expanded(
                  child: bottomNavBarItems(2, 'HomeWork', kHomeworkIcon),
                ),
                Expanded(
                  child: bottomNavBarItems(3, 'Notice', kNoticeNavIcon),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   shape: const StadiumBorder(),
        //   onPressed: () {
        //     setState(() {
        //       _selectedIndex = 3;
        //     });
        //   },
        //   tooltip: 'Home',
        //   elevation: 0,
        //   highlightElevation: 0,
        //   backgroundColor: Theme.of(context).canvasColor,
        //   child: Image.asset(
        //     kHomeNavIcon,
        //     color: Theme.of(context).primaryColor,
        //     height: 35.sp,
        //     width: 35.sp,
        //   ),
        // ),
      ),
    );
  }

  Widget bottomNavBarItems(int index, String name, String imageUrl) {
    return InkResponse(
      onTap: () => _onItemTapped(index),
      splashColor: LightThemeColors.primaryColor.withOpacity(0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 28,
            width: 28,
            color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey,
          ),
          SizedBox(height: 1.sp),
          Text(
            name,
            style: TextStyle(
              color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : Colors.grey,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
