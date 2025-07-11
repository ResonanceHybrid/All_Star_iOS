// import 'package:all_star_learning/Pages/StudentPages/Canteen/long_arrow.dart';
// import 'package:all_star_learning/config/theme/app_static_colors.dart';
// import 'package:all_star_learning/utils/custom_methods.dart';
// import 'package:all_star_learning/widgets/student/bg_button.dart';
// import 'package:all_star_learning/widgets/student/container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TransportationPage extends StatefulWidget {
//   const TransportationPage({super.key});

//   @override
//   State<TransportationPage> createState() => _TransportationPageState();
// }

// class _TransportationPageState extends State<TransportationPage> {
//   final List<Events> listOfEvents = [
//     Events(month: "Baisakh", total: "12", perMonth: "500", status: "Due"),
//     Events(month: "Jestha", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Asar", total: "12", perMonth: "500", status: "Due"),
//     Events(month: "Saun", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Bhadra", total: "12", perMonth: "500", status: "Due"),
//     Events(month: "Ashoj", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Kartik", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Mangshir", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Paush", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Magh", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Phalgun", total: "12", perMonth: "500", status: "Paid"),
//     Events(month: "Chaitra", total: "12", perMonth: "500", status: "Paid"),
//   ];
//   CustomMethods cm = CustomMethods();
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     print(height);
//     return Scaffold(
//         appBar: cm.getAppBarWithTitle(context, "Canteen Fee Page"),
//         body: Stack(
//           children: [
//             cm.getCurvedTopOnStack(context),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: ContainerWidget(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(
//                             flex: 2,
//                             child: Text(""),
//                           ),
//                           Expanded(
//                               flex: 4,
//                               child: Tooltip(
//                                 message: "Month",
//                                 child: Text(
//                                   "Month",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                           color: AppColors.mainColor,
//                                           fontWeight: FontWeight.bold),
//                                   maxLines: 1,
//                                   textAlign: TextAlign.center,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 2,
//                               child: Tooltip(
//                                 message: "Amount",
//                                 child: Text(
//                                   "Amt.",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                           color: AppColors.mainColor,
//                                           fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.center,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 2,
//                               child: Tooltip(
//                                 message: "Status",
//                                 child: Text(
//                                   "Stat.",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                           color: AppColors.mainColor,
//                                           fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.center,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               )),
//                         ],
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         color: AppColors.mainColor,
//                       ),
//                       const SizedBox(height: 10),
//                       Expanded(
//                         child: ListView(
//                           children: [
//                             ...listOfEvents.map((e) {
//                               return Row(
//                                 children: [
//                                   Expanded(
//                                       flex: 2,
//                                       child: Stack(
//                                         children: [
//                                           Container(
//                                             height: 50,
//                                             width: 1.0,
//                                             margin: const EdgeInsets.only(
//                                                 left: 10, right: 10),
//                                             color: e.status == "Due"
//                                                 ? Colors.red
//                                                 : Colors.green,
//                                           ),
//                                           Positioned(
//                                               left: 10,
//                                               top: 27,
//                                               child: StraightArrow(
//                                                 color: e.status == "Due"
//                                                     ? Colors.red
//                                                     : Colors.green,
//                                                 length: 35.sp,
//                                                 width: 1.0,
//                                                 strokeWidth: 5,
//                                               )),
//                                           Positioned(
//                                             bottom: -28,
//                                             left: -40,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(40.0),
//                                               child: Container(
//                                                 height: 20.0,
//                                                 width: 20.0,
//                                                 decoration: BoxDecoration(
//                                                   color: e.status == "Due"
//                                                       ? Colors.red
//                                                       : Colors.green,
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )),
//                                   Expanded(
//                                     flex: 4,
//                                     child: BgOutlinedbutton(
//                                       label: e.month,
//                                       onPress: () {},
//                                       bg: e.status == "Due"
//                                           ? Colors.red
//                                           : Colors.green,
//                                       textColour: e.status == "Due"
//                                           ? Colors.red
//                                           : Colors.green,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       e.perMonth,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displayLarge!
//                                           .copyWith(
//                                             color: e.status == "Due"
//                                                 ? Colors.red
//                                                 : Colors.green,
//                                           ),
//                                       textAlign: TextAlign.center,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(e.status,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .displayLarge!
//                                             .copyWith(
//                                               color: e.status == "Due"
//                                                   ? Colors.red
//                                                   : Colors.green,
//                                             ),
//                                         textAlign: TextAlign.center,
//                                         overflow: TextOverflow.ellipsis),
//                                   ),
//                                 ],
//                               );

//                               // Stack(
//                               //   children: [
//                               //     Padding(
//                               //       padding: const EdgeInsets.only(
//                               //           top: 30, bottom: 30, right: 10),
//                               //       child: Row(
//                               //         mainAxisAlignment:
//                               //             MainAxisAlignment.spaceBetween,
//                               //         children: [
//                               //           SizedBox(
//                               //             width: size.width < 350
//                               //                 ? size.width * 0.13
//                               //                 : size.width * 0.09,
//                               //           ),
//                               //           BgOutlinedbutton(
//                               //             label: e.month,
//                               //             onPress: () {},
//                               //             bg: e.status == "Due"
//                               //                 ? Colors.red
//                               //                 : Colors.green,
//                               //             textColour: e.status == "Due"
//                               //                 ? Colors.red
//                               //                 : Colors.green,
//                               //           ),
//                               //           Text(
//                               //             e.total,
//                               //             style: Theme.of(context)
//                               //                 .textTheme
//                               //                 .bodyLarge!
//                               //                 .copyWith(
//                               //                   color: e.status == "Due"
//                               //                       ? Colors.red
//                               //                       : Colors.green,
//                               //                 ),
//                               //           ),
//                               //           Text(
//                               //             e.perMonth,
//                               //             style: Theme.of(context)
//                               //                 .textTheme
//                               //                 .bodyLarge!
//                               //                 .copyWith(
//                               //                   color: e.status == "Due"
//                               //                       ? Colors.red
//                               //                       : Colors.green,
//                               //                 ),
//                               //           ),
//                               //           Text(
//                               //             e.status,
//                               //             style: Theme.of(context)
//                               //                 .textTheme
//                               //                 .bodyLarge!
//                               //                 .copyWith(
//                               //                   color: e.status == "Due"
//                               //                       ? Colors.red
//                               //                       : Colors.green,
//                               //                 ),
//                               //           ),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //     Positioned(
//                               //       left: 20,
//                               //       child: Container(
//                               //         height: size.height * 0.2,
//                               //         width: 1.0,
//                               //         color: e.status == "Due"
//                               //             ? Colors.red
//                               //             : Colors.green,
//                               //       ),
//                               //     ),
//                               //     Positioned(
//                               //       bottom: -5,
//                               //       left: -30,
//                               //       child: Padding(
//                               //         padding: const EdgeInsets.all(40.0),
//                               //         child: Container(
//                               //           height: 20.0,
//                               //           width: 20.0,
//                               //           decoration: BoxDecoration(
//                               //             color: e.status == "Due"
//                               //                 ? Colors.red
//                               //                 : Colors.green,
//                               //             borderRadius:
//                               //                 BorderRadius.circular(20),
//                               //           ),
//                               //         ),
//                               //       ),
//                               //     ),
//                               //     Positioned(
//                               //       bottom: -5,
//                               //       left: -17,
//                               //       child: Padding(
//                               //         padding: const EdgeInsets.all(40.0),
//                               //         child: Row(
//                               //           children: [
//                               //             Container(
//                               //               height: 3.0,
//                               //               width: size.width < 350
//                               //                   ? size.width * 0.08
//                               //                   : size.width * 0.10,
//                               //               decoration: BoxDecoration(
//                               //                 color: e.status == "Due"
//                               //                     ? Colors.red
//                               //                     : Colors.green,
//                               //                 borderRadius:
//                               //                     BorderRadius.circular(20),
//                               //               ),
//                               //             ),
//                               //             Icon(Icons.arrow_forward_ios,
//                               //                 color: e.status == "Due"
//                               //                     ? Colors.red
//                               //                     : Colors.green,
//                               //                 size: 20),
//                               //           ],
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   ],
//                               // );
//                             })
//                           ],
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ],
//         ));
//   }
// }

// class Events {
//   final String month;
//   final String total;
//   final String perMonth;
//   final String status;

//   Events(
//       {required this.month,
//       required this.total,
//       required this.perMonth,
//       required this.status});
// }
