// import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/theme/dark_theme_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/widgets/common_widgets/settings_popup_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/theme/light_theme_colors.dart';
import 'constants.dart';

class CustomMethods {
  void showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // void showToast(String message, Color color) {
  //   Get.snackbar(
  //     '',
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: color,
  //     colorText: Colors.white,
  //     margin: const EdgeInsets.all(10),
  //     borderRadius: 10,
  //     duration: const Duration(seconds: 2),
  //   );
  // }

  void showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      // fontSize: 16.0
    );
  }

  getAppbarWithDrawerAndAction(context1, {String? title, bool showLogo = false, bool showBackground = true}) {
    final bool isLight = Theme.of(context1).brightness == Brightness.light;
    return AppBar(
      // iconTheme: IconThemeData(
      //   color: isLight && !showBackground 
      //     ? Colors.black 
      //     : Colors.white,
      // ),
      leading: showLogo ? Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: LocalStorageMethods.getSchoolDetails()?["logo"] == ""  
          ? null 
          : Image.network(
              LocalStorageMethods.getSchoolDetails()?["logo"],
              height: 64,
              width: 64,
              fit: BoxFit.scaleDown,
            ),
      ) : null,
      title: Text(
        title ?? (showLogo ? LocalStorageMethods.getSchoolDetails()!["name"] : ""),
        style: Theme.of(context1).textTheme.headlineSmall!.copyWith(
          color: isLight && !showBackground
            ? Colors.black 
            : Colors.white,
        ),
      ),
      actions: [
        SettingsPopupButton(showBackground: showBackground),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: showBackground 
            ? AppColors.mainGradient
            : null,
          color: !showBackground 
            ? isLight
              ? LightThemeColors.scaffoldBackgroundColor
              : DarkThemeColors.scaffoldBackgroundColor
            : null,
        ),
      ),
    );
  }

  removeSubscriptionAndFirebaseToken() async {
    FirebaseMessaging.instance.unsubscribeFromTopic(
        LocalStorageMethods.getSchoolDetails()?["domain_name"] +
            "-" +
            LocalStorageMethods.getUserDetails()["data"]["role"]);
    await StudentApiMethods.uploadFCMToken(
        userId: LocalStorageMethods.getUserDetails()["data"]["id"].toString(),
        token: "");
  }

  getAppBarWithTitle(
    context,
    title, {
    bool isBack = true,
    bool isSearch = false,
    bool hideActions = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      title: Text(
        title,
      ),
      leading: !isBack
          ? const SizedBox()
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
        actions: hideActions ? null : actions ?? [
          const SettingsPopupButton(),
        ],
      // actions: actions ?? [
      //   // isSearch
      //   //     ? IconButton(
      //   //         onPressed: () {
      //   //           AppSearchController sc = Get.find<AppSearchController>();
      //   //           sc.refreshFunction();
      //   //         },
      //   //         icon: const Icon(
      //   //           Icons.refresh,
      //   //           color: Colors.white,
      //   //         ))
      //   //     : const SizedBox(),
      // ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
      ),
    );
  }

  getCurvedTopOnStack(context) {
    return Positioned(
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  // teacherCurveTopOnStack(context) {
  //   return Positioned(
  //     top: 0,
  //     child: Container(
  //       decoration: const BoxDecoration(
  //         gradient: AppColors.mainGradient,
  //         borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(15.0),
  //           bottomRight: Radius.circular(15.0),
  //         ),
  //       ),
  //       height: 120,
  //       width: MediaQuery.of(context).size.width,
  //     ),
  //   );
  // }

  teacherAppBarWithAction(String title, context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: LocalStorageMethods.getSchoolDetails()?["logo"] == ""  
          ? null 
          : Image.network(
              LocalStorageMethods.getSchoolDetails()?["logo"],
              height: 56,
              width: 56,
              fit: BoxFit.scaleDown,
            ),
      ),
      leadingWidth: 56,
      actions: [
        IconButton(
          onPressed: () async {
            Get.toNamed(
              AppPages.qrPage,
              arguments: {
              },
            );
          },
          icon: const Icon(
            Icons.qr_code_2,
          ),
        ),
        const SettingsPopupButton(showBackground: false),
      ],
      backgroundColor: isLight
        ? LightThemeColors.scaffoldBackgroundColor 
        : DarkThemeColors.scaffoldBackgroundColor,
    );
  }

  // Widget settingsPopUp({bool alternate = false}) {
  //   return PopupMenuButton(
  //     icon: Icon(
  //       Icons.more_vert,
  //       color: alternate ? Colors.black :Colors.white,
  //     ),
  //     onSelected: (value) async {
  //       if (value == '/settings') {
  //         Get.toNamed(AppPages.settings);
  //       } else if (value == '/privacy') {
  //       } else if (value == '/logout') {
  //         CustomMethods().loadingAlertDialog();
  //         await CustomMethods().removeSubscriptionAndFirebaseToken();
  //         LocalStorageMethods.removeUserDetails();
  //         Get.offAllNamed(AppPages.login);
  //       }
  //     },
  //     itemBuilder: (context) {
  //       return [
  //         PopupMenuItem(
  //           value: '/settings',
  //           child: Row(
  //             children: [
  //               const Icon(
  //                 Icons.settings,
  //                 color: AppColors.mainColor,
  //               ),
  //               SizedBox(width: 5.sp),
  //               const Text("Settings"),
  //             ],
  //           ),
  //         ),
  //         PopupMenuItem(
  //           value: '/logout',
  //           child: Row(
  //             children: [
  //               const Icon(Icons.logout, color: AppColors.mainColor),
  //               SizedBox(width: 5.sp),
  //               const Text("Logout"),
  //             ],
  //           ),
  //         ),
  //       ];
  //     },
  //   );
  // }

  teacherCurverOnStack(context) {
    return Positioned(
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  loadingAlertDialog() async {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Theme.of(context).cardColor),
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                SizedBox(width: 20.sp),
                const Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  List topicsTeacher = [
    {
      'name': 'QR\nReport',
      'icon': kAddLessonPlanTIcon,
      "route": AppPages.qrAttendanceReportSearchPage,
      "argument": {
        "route": AppPages.teacherQRAttendanceReport,
      }
    },
    {
      'name': 'Assign\n Marks',
      'icon': kAssignMarksTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign Marks",
        "route": AppPages.assignMarks,
      }
    },
    {
      'name': 'Assign\n CAS',
      'icon': kAssignCASTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign CAS",
        "route": AppPages.assignCAS,
      }
    },
    {
      'name': 'Add\n HomeWork',
      'icon': kAddHomeWorkTIcon,
      "route": AppPages.addHomeWork,
    },
    {
      'name': 'HomeWork\n List',
      'icon': kHomeWorkListTIcon,
      "route": AppPages.homeworkList,
    },
    {
      'name': 'Student\nList',
      'icon': kStudyMaterialTIcon,
      "route": AppPages.studentListPage,
    },
    {
      'name': 'Leave Application',
      'icon': kLeaveApplicationListTIcon,
      "route": AppPages.leaveApplicationList,
    },
    {
      'name': 'Exam Routine',
      'icon': kSubjectsIcon,
      "route": AppPages.teacherExamRoutine,
    },
    {
      'name': 'Complains',
      'icon': kComplainIcon,
      "route": AppPages.complainBox,
    },
    {
      'name': 'Your Attendance',
      'icon': kAttandanceTIcon,
      "route": AppPages.teacherSelfAttendanceReport,
    },
    // {
    //   'name': 'Add\n Lesson Plan',
    //   'icon': kAddLessonPlanTIcon,
    //   "route": AppPages.addLessonPlan,
    // },
    // {
    //   'name': 'Lesson\n Plan List',
    //   'icon': kAddLessonPlanTIcon,
    //   "route": AppPages.addLessonPlan,
    // },
    // {
    //   'name': 'Upload Content',
    //   'icon': kAssignmentTIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Study Material',
    //   'icon': kStudyMaterialTIcon,
    //   "route": AppPages.studyMaterial,
    // },
    // {
    //   'name': 'Upload Leave\n Application',
    //   'icon': kUploadLeaveApplicationTIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Leave Application\n List',
    //   'icon': kLeaveApplicationListTIcon,
    //   "route": AppPages.leaveApplicationList,
    // },
  ];

  List topicsClassTeacher = [
    {
      'name': 'Attendance',
      'icon': kAttandanceTIcon,
      "route": AppPages.attendanceSearchPage,
      "argument": {
        "pageTitle": "Attendance",
        "route": AppPages.teacherAttendance,
      }
    },
    {
      'name': 'Attendance\n Report',
      'icon': kAddLessonPlanTIcon,
      "route": AppPages.attendanceSearchPage,
      "argument": {
        "pageTitle": "Attendance Report",
        "route": AppPages.teacherAttandanceReport,
      }
    },
    {
      'name': 'QR\nReport',
      'icon': kQrReportIcon,
      "route": AppPages.qrAttendanceReportSearchPage,
      "argument": {
        "route": AppPages.teacherQRAttendanceReport,
      }
    },
    {
      'name': 'Marks\n Ledger',
      'icon': kMarksLedgerTIcon,
      "route": AppPages.marksLedgerSearchPage,
      "argument": {
        "pageTitle": "Marks Ledger",
        "route": AppPages.marksLedger,
      }
    },
    {
      'name': 'ECA\n Attandance',
      'icon': kAssignECATIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "ECA Attandance",
        "route": AppPages.assignECA,
      }
    },
    {
      'name': 'Assign\n Marks',
      'icon': kAssignMarksTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign Marks",
        "route": AppPages.assignMarks,
      }
    },
    {
      'name': 'Assign\n CAS',
      'icon': kAssignCASTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign CAS",
        "route": AppPages.assignCAS,
      }
    },
    {
      'name': 'Add\n HomeWork',
      'icon': kAddHomeWorkTIcon,
      "route": AppPages.addHomeWork,
    },
    {
      'name': 'HomeWork\n List',
      'icon': kHomeWorkListTIcon,
      "route": AppPages.homeworkList,
    },
    {
      'name': 'Student\nList',
      'icon': kStudyMaterialTIcon,
      "route": AppPages.studentListPage,
    },
    {
      'name': 'Leave Application',
      'icon': kLeaveApplicationListTIcon,
      "route": AppPages.leaveApplicationList,
    },
    {
      'name': 'Exam Routine',
      'icon': kExamRoutineIcon,
      "route": AppPages.teacherExamRoutine,
    },
    {
      'name': 'Complains',
      'icon': kComplainTIcon,
      "route": AppPages.complainBox,
    },
    {
      'name': 'Your Attendance',
      'icon': kAttandanceTIcon,
      "route": AppPages.teacherSelfAttendanceReport,
    },
    {
      'name': 'CAS Evaluation',
      'icon': kCasEvaluationIcon,
      "route": AppPages.searchCasEvaluation,
    },
    // {
    //   'name': 'Add\n Lesson Plan',
    //   'icon': kAddLessonPlanTIcon,
    //   "route": AppPages.addLessonPlan,
    // },
    // {
    //   'name': 'Lesson\n Plan List',
    //   'icon': kAddLessonPlanTIcon,
    //   "route": AppPages.addLessonPlan,
    // },
    // {
    //   'name': 'Upload Content',
    //   'icon': kAssignmentTIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Study Material',
    //   'icon': kStudyMaterialTIcon,
    //   "route": AppPages.studyMaterial,
    // },
    // {
    //   'name': 'Upload Leave\n Application',
    //   'icon': kUploadLeaveApplicationTIcon,
    //   "route": AppPages.createLeavePage,
    // },
  ];

  openPhoneDialer(String number) async {
    try {
      String url = "tel:$number";
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not open phone dialer';
      }   
    } catch (e) {
      showToast(e.toString(), Colors.red);
    }
  }
}
