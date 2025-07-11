import 'dart:developer';

import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/cubit/home_container_cubit.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Models/base_response_model.dart';
import '../../../Models/fee_model.dart';
import '../../../Resources/student_api_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map userDetails = {};
  bool _showFeeAmount = true;
  FeeModel? feeModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeContainerCubit>(context).getUserDetails();
    // getUserDetails();
    getFeeData();
  }

  getFeeData() async {
    BaseResponse data = await StudentApiMethods.studentFeesData();
    if (data is SuccessResponse) {
      feeModel = FeeModel.fromJson(data.data);
    } else if (data is ErrorResponse) {
    }
    setState(() {});
  }

  // getUserDetails() async {
  //   var details = LocalStorageMethods.getUserDetails();
  //   if (details != null) {
  //     userDetails = details;
  //   }
  //   setState(() {});
  // }

  List topics = [
    {
      'name': 'Online\n Class',
      'icon': kOnlineClassIcon,
      "route": AppPages.onlineclass
    },
    {
      'name': 'Fees',
      'icon': kFeesIcon,
      "route": AppPages.fees,
    },
    {
      'name': 'Results',
      'icon': kResultsIcon,
      "route": AppPages.results,
    },
    {
      'name': 'Attendance',
      'icon': kAttendanceIcon,
      "route": AppPages.events,
    },
    {
      'name': 'QR\nAttendance',
      'icon': kQrAttendanceIcon,
      "route": AppPages.studentQrReport,
    },
    {
      'name': 'Subjects',
      'icon': kSubjectsIcon,
      "route": AppPages.subjects,
    },
    {
      'name': 'Exam Routine',
      'icon': kExamRoutineSIcon,
      "route": AppPages.examRoutine,
    },
    {
      'name': 'Teachers',
      'icon': kTeachersIcon,
      "route": AppPages.teachers,
    },
    {
      'name': 'Complains',
      'icon': kComplainIcon,
      "route": AppPages.complainBox,
    },
    {
      'name': 'Call Log',
      'icon': kCallLogIcon,
      "route": AppPages.callLog,
    },
    {
      'name': 'Videos',
      'icon': kLibraryIcon,
      "route": AppPages.videos,
    },
    // {
    //   'name': 'Canteen',
    //   'icon': kCanteenIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Transport',
    //   'icon': kTransportIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    {
      'name': 'Downloads',
      'icon': kDownloadsIcon,
      "route": AppPages.downloads,
    },
    // {
    //   'name': 'Online\n Exam',
    //   'icon': kOnlineExamIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Routine',
    //   'icon': kRoutineIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Library',
    //   'icon': kLibraryIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
    // {
    //   'name': 'Dormitory',
    //   'icon': kDromitoryIcon,
    //   "route": AppPages.commingSoonPageWithBackAppbar,
    // },
  ];
  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    log("DDD: ${LocalStorageMethods.getUserDetails()['device_token']}");
    log("FFF: ${LocalStorageMethods.getFcmToken()}");
    log(LocalStorageMethods.getUserDetails().toString());
    return Scaffold(
      appBar: cm.getAppbarWithDrawerAndAction(
        context, 
        showLogo: true, 
        showBackground: false,
      ),
      drawerEnableOpenDragGesture: true,
      //drawer:.const StudentDrawerWidget(),
      body: Stack(
        children: [
          ListView(
            physics: const NeverScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            children: [
              SizedBox(height: 205.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 110.h,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 5,
                ),
                itemCount: topics.length,
                itemBuilder: (BuildContext ctx, index) {
                  var item = topics[index];
                  return topicsWidget(
                    context, 
                    item["icon"],
                    item["name"], 
                    item["route"],
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
          Positioned(
            top: 40.h,
            left: 10,
            right: 10,
            child: BlocBuilder<HomeContainerCubit, HomeContainerState>(
              builder: (context, state) {
                final Map<String, dynamic>? userDetails = state.userDetails;
                return ContainerWidget(
                  gradient: AppColors.homeGradient,
                  radius: 25,
                  padding: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 45.h, bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userDetails?["data"]["name"] ?? "N/A"}",
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "${userDetails?["data"]["email"] ?? "N/A"}",
                              style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                              ),
                            ),
                        
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppPages.studentprofile,
                                        arguments: false,
                                      );
                                    },
                                    child: Text(
                                      "View Profile",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: const Color(0xFFEDCB67),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 32.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              AppPages.fees,
                                              arguments: false,
                                            );
                                          },
                                          child: Text(
                                            "Rs. ${_showFeeAmount 
                                              ? feeModel?.summary.values.last?.toString() ?? ""
                                              : feeModel?.summary.values.last?.toString().replaceAll(RegExp(r'\d'), 'X') ?? ""}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _showFeeAmount = !_showFeeAmount;
                                          });
                                        }, 
                                        child: Icon(
                                          _showFeeAmount ? Icons.visibility : Icons.visibility_off, 
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 2.0),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: const Color(0xFFEDCB67),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          Positioned(
            top: 0,
            left: 45,
            child: BlocBuilder<HomeContainerCubit, HomeContainerState>(
              builder: (context, state) {
                final Map<String, dynamic>? userDetails = state.userDetails;
                return CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    userDetails?["data"]["image"] ??
                      "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                  ),
                  radius: 40,
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  SizedBox topicsWidget(BuildContext context, icon, title, route) {
    return SizedBox(
      height: 107,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(route);
          },
          child: ContainerWidget(
            radius: 10,
            padding: 5,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w200,
                      color: AppColors.textDarkColorGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
