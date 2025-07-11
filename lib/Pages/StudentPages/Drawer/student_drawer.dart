// import 'package:all_star_learning/Utils/local_storage.dart';
// import 'package:all_star_learning/routes/app_pages.dart';
// import 'package:all_star_learning/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// class StudentDrawerWidget extends StatefulWidget {
//   const StudentDrawerWidget({super.key});

//   @override
//   State<StudentDrawerWidget> createState() => _StudentDrawerWidgetState();
// }

// class _StudentDrawerWidgetState extends State<StudentDrawerWidget> {
//   Map userDetails = {};

//   @override
//   void initState() {
//     super.initState();
//     getUserDetails();
//   }

//   getUserDetails() async {
//     var details = LocalStorageMethods.getUserDetails();
//     if (details != null) {
//       userDetails = details;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Material(
//         color: const Color(0xffFD8872),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     buildHeader(
//                       context: context,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Divider(
//                         color: Colors.white,
//                         thickness: 5,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           // const SizedBox(height: 12),
//                           buildMenuItem(
//                               context: context,
//                               text: 'Home',
//                               icon: FontAwesomeIcons.house,
//                               onClicked: () => Get.offAndToNamed(
//                                   AppPages.studentNavigation)),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),

//                           buildMenuItem(
//                               context: context,
//                               text: 'Student Profile',
//                               icon: FontAwesomeIcons.userGraduate,
//                               onClicked: () => Get.toNamed(
//                                   AppPages.studentprofile,
//                                   arguments: false)),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Fees',
//                             icon: Icons.attach_money,
//                             onClicked: () => Get.toNamed(AppPages.fees),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Results',
//                             icon: Icons.bar_chart,
//                             onClicked: () => Get.toNamed(AppPages.results),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Attendence',
//                             icon: Icons.calendar_today,
//                             onClicked: () => Get.toNamed(AppPages.attendance),
//                             // onClicked: () => Get.toNamed(AppPages.attendance),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Subjects',
//                             icon: Icons.book,
//                             onClicked: () => Get.toNamed(AppPages.subjects),
//                           ),
//                           // const Divider(
//                           //   height: 5,
//                           //   thickness: 2,
//                           //   color: Colors.white,
//                           // ),
//                           // buildMenuItem(
//                           //   context: context,
//                           //   text: 'Routine',
//                           //   icon: Icons.schedule,
//                           //   onClicked: () => Get.toNamed(AppPages.routine),
//                           // ),

//                           // const Divider(
//                           //   height: 5,
//                           //   thickness: 2,
//                           //   color: Colors.white,
//                           // ),
//                           // buildMenuItem(
//                           //   context: context,
//                           //   text: 'Online Exams',
//                           //   icon: Icons.assignment,
//                           //   onClicked: () => Get.toNamed(AppPages.onlineExam),
//                           // ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Teachers',
//                             icon: FontAwesomeIcons.chalkboardTeacher,
//                             onClicked: () => Get.toNamed(AppPages.teachers),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           // buildMenuItem(
//                           //   context: context,
//                           //   text: 'Dormitory',
//                           //   icon: FontAwesomeIcons.hotel,
//                           //   // onClicked: () => Get.toNamed(AppPages.dromitory),
//                           //   onClicked: () =>
//                           //       Get.toNamed(AppPages.commingSoonPageWithBackAppbar),
//                           // ),
//                           // const Divider(
//                           //   height: 5,
//                           //   thickness: 2,
//                           //   color: Colors.white,
//                           // ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Transport',
//                             icon: Icons.bus_alert_sharp,
//                             // onClicked: () => Get.toNamed(AppPages.transport),
//                             onClicked: () => Get.toNamed(
//                                 AppPages.commingSoonPageWithBackAppbar),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Downloads',
//                             icon: Icons.download,
//                             onClicked: () => Get.toNamed(AppPages.downloads),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Canteen',
//                             icon: Icons.local_dining,
//                             // onClicked: () => Get.toNamed(AppPages.canteen),
//                             onClicked: () => Get.toNamed(
//                                 AppPages.commingSoonPageWithBackAppbar),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Videos',
//                             icon: Icons.video_stable,
//                             onClicked: () => Get.toNamed(AppPages.videos),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Complains',
//                             icon: Icons.feedback_rounded,
//                             onClicked: () => Get.toNamed(AppPages.complainBox),
//                           ),
//                           const Divider(
//                             height: 5,
//                             thickness: 2,
//                             color: Colors.white,
//                           ),
//                           buildMenuItem(
//                             context: context,
//                             text: 'Call Logs',
//                             icon: Icons.call,
//                             onClicked: () => Get.toNamed(AppPages.callLog),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   decoration: const BoxDecoration(color: Colors.white),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset(
//                         klogoImage,
//                         height: 35,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             "assets/images/facebook.png",
//                             height: 30,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 7),
//                             child: Image.asset(
//                               "assets/images/youtube.png",
//                               height: 30,
//                             ),
//                           ),
//                           Image.asset(
//                             "assets/images/linkedin.png",
//                             height: 30,
//                           ),
//                         ],
//                       )
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHeader({
//     required BuildContext context,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(userDetails["data"]["image"] ??
//                 "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
//             radius: 35, // adjust as necessary
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "${userDetails["data"]["name"] ?? "N/A"}",
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineSmall!
//                     .copyWith(color: Colors.white),
//               ),
//               Text(
//                 "Class : ${userDetails["data"]["class_name"] ?? "N/A"}  |  Sec : ${userDetails["data"]["section_name"] ?? "N/A"}",
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium!
//                     .copyWith(color: Colors.white),
//               ),
//               // Text(
//               //   "Roll No : 1",
//               //   style: Theme.of(context)
//               //       .textTheme
//               //       .bodyMedium!
//               //       .copyWith(color: Colors.white),
//               // )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildMenuItem({
//     required BuildContext context,
//     required String text,
//     required IconData icon,
//     Function()? onClicked,
//   }) {
//     return InkWell(
//       onTap: onClicked,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Icon(
//               icon,
//               size: 26,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               text,
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(color: Colors.white, fontWeight: FontWeight.w200),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
