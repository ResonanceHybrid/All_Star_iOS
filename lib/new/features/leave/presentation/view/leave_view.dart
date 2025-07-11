import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_state.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/custom_methods.dart';
import '../../../../../widgets/common_widgets/settings_popup_button.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<LeaveCubit>().getAllLeaves();
          },
          child: Scaffold(
            appBar: CustomMethods().getAppBarWithTitle(
              context, 
              "Leave Requests", 
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.add_circle_rounded,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.toNamed(AppPages.createLeavePage);
                  },
                ),
                const SettingsPopupButton(),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 0.8.sh,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: state.leaves.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final LeaveEntity item = state.leaves[index];
                      return GestureDetector(
                        onTap: () {},
                        child: LeaveCard(
                          item: item,
                        ),
                        // ListTile(
                        //   title: Text(
                        //     "${item.subject}",
                        //     style: TextStyle(
                        //       fontSize: 16.sp,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   subtitle: Row(
                        //     children: [
                        //       // User
                        //       Text(
                        //         "${item.user}",
                        //         style: TextStyle(
                        //           fontSize: 14.sp,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.textLightDarkColorGrey,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10.w,
                        //       ),
                        //       // From and To
                        //       Text(
                        //         "${item.dateFrom} TO ${item.dateTo}",
                        //         style: const TextStyle(
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   trailing: IconButton(
                        //     icon: const Icon(Icons.delete),
                        //     onPressed: () {
                        //       _showDeleteDialog(context, item);
                        //     },
                        //   ),
                        // ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeaveCard extends StatelessWidget {
  const LeaveCard({
    super.key,
    required this.item,
  });

  final LeaveEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 8.r,
            spreadRadius: 2.r,
            offset: const Offset(4, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title of Leave
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        SizedBox(
                          width: 0.8.sw,
                          child: Text(
                            item.subject ?? "N/A",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLightDarkColorGrey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        // Date
                        Text(
                          "${item.dateFrom?.replaceAll('-', '/')} - ${item.dateTo?.replaceAll('-', '/')}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLightDarkColorGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    // Reason
                    Text(
                      item.reason ?? "N/A",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLightDarkColorGrey,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                  ],
                ),
                if(item.isApproved == 1)
                  const Icon(
                    Icons.check_circle_rounded, 
                    color: Colors.green,
                  )
              ],
            ),
          ),
          // Approve or Reject
          if(item.isApproved != 1)
            Row(
              children: [
                //? Approved Status
                Expanded(
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                      margin: EdgeInsets.only(top: 12.h),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[400]!),
                          right: BorderSide(color: Colors.grey[400]!),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel_rounded,
                            size: 16.r,
                            color:
                                Colors.red,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Not Approved",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textLightDarkColorGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //? View Button
                if (item.edit == true)
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.toNamed(
                          AppPages.updateLeavePage,
                          arguments: item,
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.only(top: 12.h),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(color: Colors.grey[400]!),
                            right: BorderSide(color: Colors.grey[400]!),
                            top: BorderSide(color: Colors.grey[400]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_rounded,
                              size: 16.r,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textLightDarkColorGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                //? Delete Button
                if (item.delete == true)
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        _showDeleteDialog(context, item);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.only(top: 12.h),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey[400]!),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_forever_rounded,
                              size: 16.r,
                              color: AppColors.mainColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textLightDarkColorGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )
          // Row(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         color: item.isApproved == 1 ? Colors.green : Colors.red,
          //         borderRadius: BorderRadius.circular(5.r),
          //       ),
          //       width: item.isApproved == 1 ? 80.w : 100.w,
          //       height: 20.h,
          //       child: Center(
          //         child: Text(
          //           item.isApproved == 1 ? "Approved" : "Not Approved",
          //           style: TextStyle(
          //             fontSize: 10.sp,
          //             fontWeight: FontWeight.w400,
          //             color: AppColors.textLightDarkColorGrey,
          //           ),
          //           textAlign: TextAlign.end,
          //         ),
          //       ),
          //     ),
          //     // Delete Button
          //     IconButton(
          //       icon: Icon(
          //         Icons.delete,
          //         size: 20.sp,
          //         color: Colors.red,
          //       ),
          //       onPressed: () {
          //         _showDeleteDialog(context, item);
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, LeaveEntity item) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Theme.of(context).cardColor),
          child: AlertDialog(
            content: Text(
              "Are you sure you want to delete this leave request?",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.textDarkColorGrey,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<LeaveCubit>().deleteLeave(
                        leaveId: item.id ?? 0,
                        onSuccess: () {
                          BlocProvider.of<LeaveCubit>(context).getAllLeaves();
                          Navigator.of(context).pop();
                        },
                      );
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
