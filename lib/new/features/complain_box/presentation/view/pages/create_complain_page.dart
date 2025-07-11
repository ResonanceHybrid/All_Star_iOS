import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_cubit.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateComplainPage extends StatefulWidget {
  const CreateComplainPage({super.key});

  @override
  State<CreateComplainPage> createState() => _CreateComplainPageState();
}

class _CreateComplainPageState extends State<CreateComplainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ComplainBoxCubit>(context).clearSelectedRoleUsers();
    BlocProvider.of<ComplainBoxCubit>(context).getRoleList();
  }

  final _formKey = GlobalKey<FormState>();
  final _complainTitleController = TextEditingController();
  final _complainDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainBoxCubit, ComplainBoxState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Create Complain'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Role
                Text(
                  "Selected Role",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    enabled: true,
                    border: const OutlineInputBorder(),
                  ),
                  items: state.roleList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name ?? ""),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    BlocProvider.of<ComplainBoxCubit>(context)
                        .selectRole(value);
                    BlocProvider.of<ComplainBoxCubit>(context)
                        .getRoleUserList(roleId: value ?? 0);
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  "Selected Teachers",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    enabled: true,
                    border: const OutlineInputBorder(),
                  ),
                  items: state.roleUsersList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name ?? "",
                              style: TextStyle(
                                color: state.selectedRoleUser.contains(e)
                                    ? Colors.grey
                                    : Colors.black,
                              )),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    BlocProvider.of<ComplainBoxCubit>(context)
                        .selectToleUsers(value);
                  },
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: state.selectedRoleUser
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e.name ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ComplainBoxCubit>(context)
                                      .removeSelectedRoleUser(e.id);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(height: 16.h),
// Subject
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KTextFormField(
                        topLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: const Color(0xFFdedfde),
                        topLabelText: "Title",
                        hintText: "Enter Title",
                        controller: _complainTitleController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required field *";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      KTextFormField(
                        topLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: const Color(0xFFdedfde),
                        topLabelText: "Description",
                        controller: _complainDescriptionController,
                        keyboardType: TextInputType.text,
                        hintText: "Enter Description",
                        maxLines: 8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required field *";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                // Submit Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<ComplainBoxCubit>(context)
                            .createComplain(
                          complainToIds: state.selectedRoleUser
                              .map((e) => e.id ?? 0)
                              .toList(),
                          roleId: state.selectedRole?.id ?? 0,
                          title: _complainTitleController.text,
                          description: _complainDescriptionController.text,
                          onError: (error) {
                            CustomMethods()
                                .showSnackBar(context, error, Colors.red);
                          },
                          onSuccess: () {
                            CustomMethods().showSnackBar(
                              context,
                              "Complain created successfully",
                              Colors.green,
                            );
                            BlocProvider.of<ComplainBoxCubit>(context)
                                .clearSelectedRoleUsers();
                            _complainTitleController.clear();
                            _complainDescriptionController.clear();
                            Get.back();
                            BlocProvider.of<ComplainBoxCubit>(context)
                                .getAllComplains();
                          },
                        );
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        width: 200.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
