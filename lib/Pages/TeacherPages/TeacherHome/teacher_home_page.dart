import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/cubit/home_container_cubit.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  CustomMethods cm = CustomMethods();

  @override
  void initState() {
    super.initState();
    Get.put(SearchController());
    Get.put(AppSearchController());
    BlocProvider.of<HomeContainerCubit>(context).getUserDetails();
    BlocProvider.of<QrCubit>(context).getScanTypes(report: false);
  }
  @override
  Widget build(BuildContext context) {
    bool role = LocalStorageMethods.getUserDetails()["data"]["is_class_teacher"] ?? false;
    return Scaffold(
      appBar: cm.teacherAppBarWithAction(
        LocalStorageMethods.getSchoolDetails()["name"],
        context,
      ),
      drawerEnableOpenDragGesture: true,
      body: Stack(
        children: [
          ListView(
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
                itemCount: role
                  ? cm.topicsClassTeacher.length
                  : cm.topicsTeacher.length,
                itemBuilder: (BuildContext ctx, index) {
                  var item = role
                    ? cm.topicsClassTeacher[index]
                    : cm.topicsTeacher[index];
                  return topicsWidget(
                    context,
                    item["icon"],
                    item["name"],
                    item["route"],
                    item["argument"],
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
          // cm.teacherCurverOnStack(context),
          Positioned(
            top: 40.h,
            left: 10,
            right: 10,
            child: BlocBuilder<HomeContainerCubit, HomeContainerState>(
              builder: (context, state) {
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
                              "${state.userDetails?["data"]["name"] ?? "N/A"}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "${state.userDetails?["data"]["email"] ?? "N/A"}",
                              style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
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
                                        AppPages.teacherSelfAttendanceReport,
                                      );
                                    },
                                    child: Text(
                                      "Your Attendance",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppPages.teacherProfile,
                                      );
                                    },
                                    child: Text(
                                      "View Profile",
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Stack(
                                    alignment: Alignment.centerRight,
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
                return CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    state.userDetails?["data"]["image"] ??
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

  SizedBox topicsWidget(BuildContext context, icon, title, route, [Map<String, dynamic>? argument]) {
    return SizedBox(
      height: 107,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            argument != null
                ? Get.toNamed(
                    route,
                    arguments: argument,
                  )
                : Get.toNamed(
                    route,
                  );
          },
          child: ContainerWidget(
            radius: 10,
            padding: 5,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: Image.asset(
                      icon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.textDarkColorGrey,
                        fontWeight: FontWeight.w200,
                      ),
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
