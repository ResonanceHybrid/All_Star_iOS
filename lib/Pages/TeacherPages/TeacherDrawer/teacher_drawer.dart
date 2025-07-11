import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherDrawer extends StatefulWidget {
  const TeacherDrawer({super.key});

  @override
  State<TeacherDrawer> createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
  List topics = [
    // {
    //   'name': 'Online\n Class',
    //   'icon': kOnlineClassTIcon,
    //   "route": AppPages.teacherOnlineClass
    // },
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
      'name': 'Attendance Report',
      'icon': kAddLessonPlanTIcon,
      "route": AppPages.attendanceSearchPage,
      "argument": {
        "pageTitle": "Attendance Report",
        "route": AppPages.teacherAttandanceReport,
      }
    },
    {
      'name': 'Assign Marks',
      'icon': kAssignMarksTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign Marks",
        "route": AppPages.assignMarks,
      }
    },
    {
      'name': 'Assign ECA',
      'icon': kAssignECATIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign ECA",
        "route": AppPages.assignECA,
      }
    },
    {
      'name': 'Assign CAS',
      'icon': kAssignCASTIcon,
      "route": AppPages.searchPage,
      "argument": {
        "pageTitle": "Assign CAS",
        "route": AppPages.assignCAS,
      }
    },
    {
      'name': 'Marks Ledger',
      'icon': kMarksLedgerTIcon,
      "route": AppPages.marksLedgerSearchPage,
      "argument": {
        "pageTitle": "Marks Ledger",
        "route": AppPages.marksLedger,
      }
    },
    {
      'name': 'Add HomeWork',
      'icon': kAddHomeWorkTIcon,
      "route": AppPages.addHomeWork,
    },
    {
      'name': 'HomeWork List',
      'icon': kHomeWorkListTIcon,
      "route": AppPages.homeworkList,
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
    //   "route": AppPages.teacherAssignment,
    // },
    // {
    //   'name': 'Study Material',
    //   'icon': kStudyMaterialTIcon,
    //   "route": AppPages.studyMaterial,
    // },
    // {
    //   'name': 'Upload Leave\n Application',
    //   'icon': kUploadLeaveApplicationTIcon,
    //   "route": AppPages.uploadLeaveApplication,
    // },
    // {
    //   'name': 'Leave Application\n List',
    //   'icon': kLeaveApplicationListTIcon,
    //   "route": AppPages.leaveApplicationList,
    // },
  ];
  @override
  Widget build(BuildContext context) {
    Map userDetails = LocalStorageMethods.getUserDetails();

    return Drawer(
      child: Material(
        color: const Color(0xffFD8872),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  buildHeader(
                    context: context,
                    userDetails: userDetails,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.white,
                      thickness: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ...topics.map((e) => Column(
                              children: [
                                buildMenuItem(
                                  context: context,
                                  text: e['name'],
                                  icon: e['icon'],
                                  onClicked: () {
                                    e['argument'] != null
                                        ? Get.toNamed(
                                            e["route"],
                                            arguments: e['argument'],
                                          )
                                        : Get.toNamed(
                                            e["route"],
                                          );
                                  },
                                ),
                                const Divider(
                                  height: 5,
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // margin: const EdgeInsets.only(bottom: 25),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        klogoImage,
                        height: 35,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/facebook.png",
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Image.asset(
                              "assets/images/youtube.png",
                              height: 30,
                            ),
                          ),
                          Image.asset(
                            "assets/images/linkedin.png",
                            height: 30,
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required BuildContext context,
    required var userDetails,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userDetails["data"]["image"] ??
                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
            radius: 35, // adjust as necessary
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDetails["data"]["name"] ?? "N/A",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
              Text(
                userDetails["data"]["email"] ?? "N/A",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required BuildContext context,
    required String text,
    required String icon,
    Function()? onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
