import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/student_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailedStudentPage extends StatefulWidget {
  const DetailedStudentPage({super.key});

  @override
  State<DetailedStudentPage> createState() => _DetailedStudentPageState();
}

class _DetailedStudentPageState extends State<DetailedStudentPage> {
  late StudentEntity student;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    student = ModalRoute.of(context)!.settings.arguments as StudentEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            height: 100.h,
            padding: EdgeInsets.all(16.w),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFff696b),
                  Color.fromARGB(255, 238, 147, 150),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Student Image
                Row(
                  children: [
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: (student.image != null && student.image != "")
                          ? Image.network(student.image!, fit: BoxFit.cover)
                          : Center(
                              child: Text(
                                student.name![0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(width: 10.w),
                    // Student Name
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          student.email!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${student.className ?? ""} | ${student.sectionName ?? ""}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await CustomMethods().openPhoneDialer(student.parentDetails!.guardianPhone!);
                  }, 
                  icon: const Icon(Icons.phone_android_outlined, size: 40, color: Colors.white),
                )
              ],
            ),
          ),
          // Student Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SizedBox(
              width: 1.sw,
              height: 600.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Parent Details
                    Container(
                      padding: EdgeInsets.all(12.w),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 8.r,
                            spreadRadius: 2.r,
                            offset: const Offset(4, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Parents Details",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(),
                          SizedBox(height: 10.h),
                          DetailTextWidget(
                            title: "Father Name",
                            detail: student.parentDetails?.fatherName ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Father Occupation",
                            detail: student.parentDetails?.fatherOccupation ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Father Phone",
                            detail: student.parentDetails?.fatherPhone ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Mother Name",
                            detail: student.parentDetails?.motherName ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Mother Occupation",
                            detail: student.parentDetails?.motherOccupation ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Mother Phone",
                            detail: student.parentDetails?.motherPhone ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Parent Address",
                            detail: student.parentDetails?.parentAddress ?? "N/A",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 8.r,
                            spreadRadius: 2.r,
                            offset: const Offset(4, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guardian Details",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(),
                          SizedBox(height: 10.h),
                          DetailTextWidget(
                            title: "Guardian Name",
                            detail: student.parentDetails?.guardianName ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Guardian Occupation",
                            detail:
                                student.parentDetails?.guardianOccupation ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Guardian Phone",
                            detail: student.parentDetails?.guardianPhone ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Guardian Address",
                            detail: student.parentDetails?.guardianAddress ?? "N/A",
                          ),
                          SizedBox(height: 10.h),

                          DetailTextWidget(
                            title: "Guardian Email",
                            detail: student.parentDetails?.guardianEmail ?? "N/A",
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTextWidget extends StatelessWidget {
  const DetailTextWidget({
    super.key,
    required this.title,
    required this.detail,
  });

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5.h),
        // Detail
        Text(
          detail,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
