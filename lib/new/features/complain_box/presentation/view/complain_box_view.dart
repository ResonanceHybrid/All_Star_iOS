import 'dart:developer';

import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_cubit.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_state.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/local_storage.dart';
import 'package:all_star_learning/widgets/common_widgets/settings_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComplainBoxView extends StatefulWidget {
  const ComplainBoxView({super.key});

  @override
  State<ComplainBoxView> createState() => _ComplainBoxViewState();
}

class _ComplainBoxViewState extends State<ComplainBoxView> {
  CustomMethods cm = CustomMethods();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ComplainBoxCubit>(context).getAllComplains();
    BlocProvider.of<ComplainBoxCubit>(context).getRoleList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainBoxCubit, ComplainBoxState>(
      builder: (context, state) {
        log(
          'ComplainBoxView: ${LocalStorageMethods.getUserDetails()["data"]['role']}',
        );
        return Scaffold(
          appBar: cm.getAppBarWithTitle(
            context, 
            "Complains", 
            actions: [
              LocalStorageMethods.getUserDetails()["data"]['role'] == "teacher"
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed(AppPages.createComplain);
                    },
                  ),
              const SettingsPopupButton(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 8),
            child: Center(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<ComplainBoxCubit>(context)
                            .getAllComplains();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.complains.length,
                              itemBuilder: (context, index) {
                                final complain = state.complains[index];
            
                                return GestureDetector(
                                  onTap: () {
                                    if (complain.show == true) {
                                      BlocProvider.of<ComplainBoxCubit>(
                                              context)
                                          .selectComplain(complain);
                                      Get.toNamed(
                                        AppPages.viewComplain,
                                      );
                                    }
                                  },
                                  child: ComplainListCard(
                                    complain: complain,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class ComplainListCard extends StatelessWidget {
  const ComplainListCard({
    super.key,
    required this.complain,
  });

  final ComplainEntity complain;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title of the Complain and Poster Name and Date, with Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title of the Complain and Poster Name and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.50.sw,
                    child: Text(
                      complain.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Poster Name and Date
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     // Poster Name
                  //     // Text(
                  //     //   'By: ${complain.complainBy}',
                  //     //   maxLines: 1,
                  //     //   overflow: TextOverflow.ellipsis,
                  //     //   style: TextStyle(
                  //     //     fontSize: 12.sp,
                  //     //     fontWeight: FontWeight.w400,
                  //     //     color: Colors.grey,
                  //     //   ),
                  //     // ),
                  //     // Date
                  //     Text(
                  //       "On: ${complain.createdAt ?? ''}",
                  //       style: TextStyle(
                  //         fontSize: 12.sp,
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Text(
                "On: ${complain.createdAt ?? ''}",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              // Status of the Complain

              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 8.w,
              //     vertical: 4.h,
              //   ),
              //   decoration: BoxDecoration(
              //     color: complain.isApproved == 1 ? Colors.green : Colors.red,
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Text(
              //     complain.isApproved == 1 ? 'Approved' : 'Not Approved',
              //     style: TextStyle(
              //       fontSize: 10.sp,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 8.h),
          // Description of the Complain (Few Lines)
          Text(
            complain.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12.h),
          // One Reply to the Complain if any
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              complain.replies!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              complain.replies!.length > 1
                                  ? 'Replies: '
                                  : 'Reply: ',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "(${complain.replies!.length})",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 4.h),
                        // Text(
                        //   complain.replies?.first.createdBy ?? '',
                        //   style: TextStyle(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // Text(
                        //   complain.replies?.first.description ?? '',
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //     fontSize: 10.sp,
                        //     fontWeight: FontWeight.w300,
                        //   ),
                        // )
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      // color: complain.isApproved == 1 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      complain.isApproved == 1 ? 'Approved' : 'Pending',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: complain.isApproved == 1
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      // color: complain.isApproved == 1 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      complain.isActive == 1 ? 'Open' : 'Closed',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            complain.isActive == 1 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
