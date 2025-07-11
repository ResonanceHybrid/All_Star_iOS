import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/student_entity.dart';
import 'package:all_star_learning/new/features/student_list/presentation/cubit/student_list_cubit.dart';
import 'package:all_star_learning/new/features/student_list/presentation/cubit/student_list_state.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../widgets/teacher/search_dropdown.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentListCubit>(context).getClassList();
    BlocProvider.of<StudentListCubit>(context).initial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentListCubit, StudentListState>(
      builder: (context, state) {
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            StudentListCubit studentListCubit = BlocProvider.of<StudentListCubit>(context);
            if(studentListCubit.state.selectedClassId != null && studentListCubit.state.selectedSectionId != null) {
              studentListCubit.getStudentList(classId: studentListCubit.state.selectedClassId!, sectionId: studentListCubit.state.selectedSectionId!);
            }
          },
          child: Scaffold(
            appBar: CustomMethods().getAppBarWithTitle(context, "Students"),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  // Dropdown to select classes
                  SearchDropDown(
                    hintText: "Select Class",
                    data: state.classList,
                    onChanged: (value) {
                      BlocProvider.of<StudentListCubit>(context).setSelectedClassId(int.tryParse(value));
                      BlocProvider.of<StudentListCubit>(context).getClassSectionList(classId: int.parse(value ?? 0));
                    },
                    value: state.selectedClassId?.toString(),
                  ),
          
                  SizedBox(height: 20.h),
                  // Dropdown to select classes
                  SearchDropDown(
                    hintText: "Select Section",
                    data: state.sectionList,
                    onChanged: (value) {
                      BlocProvider.of<StudentListCubit>(context).setSelectedSectionId(value);
                      BlocProvider.of<StudentListCubit>(context).getStudentList(
                        classId: state.selectedClassId ?? 0,
                        sectionId: value ?? 0,
                      );
                    },
                    value: state.selectedSectionId?.toString(),
                  ),
                  SizedBox(height: 20.h),
          
                  Text(
                    "Students",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Student list
                  Expanded(
                    child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (state.selectedClassId != null && state.selectedSectionId != null)
                          ? ListView.builder(
                              itemCount: state.studentList.length,
                              itemBuilder: (context, index) {
                                final student = state.studentList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppPages.studentDetailPage,
                                      arguments: student,
                                    );
                                  },
                                  child: StudentListCard(
                                    student: student,
                                  ),
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StudentListCard extends StatelessWidget {
  const StudentListCard({
    super.key,
    required this.student,
  });

  final StudentEntity student;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Student Image and Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: (student.image != null && student.image != "")
                        ? DecorationImage(
                            image: NetworkImage(student.image ?? ""),
                            fit: BoxFit.cover,
                          )
                        : null,
                      color: AppColors.mainColor.withOpacity(0.2),
                    ),
                    child: student.image == null || student.image == ""
                      ? Center(
                          child: Text(
                            student.name![0],
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        student.email ?? "",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${student.className ?? ""} | ${student.sectionName ?? ""}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: student.parentDetails?.guardianPhone != null ? () async {
                  await CustomMethods().openPhoneDialer(student.parentDetails!.guardianPhone!);
                } : null, 
                icon: const Icon(Icons.call, color: AppColors.mainColor, size: 30,),
              )
            ],
          ),
          // Guardian's Name and Phone
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Guardian : ",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  student.parentDetails?.guardianName ?? "",
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Contact : ",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  student.parentDetails?.guardianPhone ?? "",
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
