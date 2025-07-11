import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_cubit.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_state.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class ViewComplainPage extends StatefulWidget {
  const ViewComplainPage({super.key});

  @override
  State<ViewComplainPage> createState() => _ViewComplainPageState();
}

class _ViewComplainPageState extends State<ViewComplainPage> {
  CustomMethods cm = CustomMethods();

  ComplainEntity? complainEntity;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _complainTitleController;
  late TextEditingController _complainDescriptionController;
  final TextEditingController _replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _complainTitleController = TextEditingController();
    _complainDescriptionController = TextEditingController();

    // Accessing ComplainBoxCubit and setting up initial values
    final complainBoxCubit = BlocProvider.of<ComplainBoxCubit>(context);
    complainEntity = complainBoxCubit.state.selectedComplain;
    if (complainEntity != null) {
      _initializeComplainDetails(complainBoxCubit);
    }
  }

  Future<void> _initializeComplainDetails(
      ComplainBoxCubit complainBoxCubit) async {
    // Load role list
    await complainBoxCubit.getRoleList();

    // Set initial values for text controllers
    _complainTitleController.text = complainEntity!.title ?? "";
    _complainDescriptionController.text = complainEntity!.description ?? "";

    // Select initial role
    complainBoxCubit.selectRole(complainEntity!.roleId ?? 0);

    // Load role user list
    await complainBoxCubit.getRoleUserList(roleId: complainEntity!.roleId ?? 0);

    // Select initial role users
    for (var element in complainEntity!.complainTo ?? []) {
      complainBoxCubit.selectToleUsers(element.id);
    }
  }

  @override
  void dispose() {
    _complainTitleController.dispose();
    _complainDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplainBoxCubit, ComplainBoxState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            title: const Text('View Complain'),
            actions: LocalStorageMethods.getUserDetails()["data"]['role'] == "teacher"
                ? []
                : [
                    complainEntity?.edit == false
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (complainEntity?.edit == false) {
                                return;
                              }
                              Get.toNamed(
                                AppPages.updateComplain,
                                arguments: complainEntity,
                              );
                            },
                          ),
                    complainEntity?.delete == false
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (complainEntity?.delete == false) {
                                return;
                              }
                              _showDeleteDialog(context);
                            },
                          ),
                  ],
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: AppColors.mainGradient),
            ),
          ),
          floatingActionButton: complainEntity?.isActive == 0
            ? null
            : FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                onPressed: () {
                  // Show Modal Bottom Sheet to Add Reply
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12.h),
                                    KTextFormField(
                                      hintText: "Your Reply",
                                      topLabelText: "Add Reply",
                                      topLabelStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3,
                                      fillColor: const Color(0xFFdedfde),
                                      controller: _replyController,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Required field *";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_formKey.currentState!.validate()) {
                                            BlocProvider.of<ComplainBoxCubit>(context).createReply(
                                              complainId: complainEntity?.id ?? 0,
                                              description: _replyController.text,
                                              onError: (error) {
                                                CustomMethods().showSnackBar(
                                                  context,
                                                  error,
                                                  Colors.red,
                                                );
                                              },
                                              onSuccess: () {
                                                CustomMethods().showSnackBar(
                                                  context,
                                                  "Replied successfully",
                                                  Colors.green,
                                                );
                                                BlocProvider.of<ComplainBoxCubit>(context).getSingleComplain(
                                                  complainId: complainEntity?.id ?? 0,
                                                );
                                                _replyController.clear();
                                                Get.back();
                                              },
                                            );
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 6.h,
                                          ),
                                          width: 100.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Center(
                                            child: state.isLoading
                                              ? const CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                )
                                              : Text(
                                                  "Reply",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.reply,
                  color: Colors.white,
                ),
              ),
          body: Container(
            margin: const EdgeInsets.only(left: 10, top: 10, right: 8),
            child: state.isLoading
                ? const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    child: Column(
                      children: [
                        _buildShowStatus(state),
                        SizedBox(
                          height: 0.8.sh,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 16.h),
                                // _buildSelectedRoleSection(state),
                                SizedBox(height: 16.h),
                                _buildSelectedTeachersSection(state),
                                SizedBox(height: 16.h),
                                _buildComplainDetailsForm(),
                                SizedBox(height: 16.h),
                                _buildReplySection(state),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildShowStatus(ComplainBoxState state) {
    return Row(
      children: [
        Text(
          "Status: ",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: complainEntity?.isActive == 1 ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            complainEntity?.isActive == 0 ? "Closed" : "Open",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          "Approved: ",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: complainEntity?.isApproved == 1 ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            complainEntity?.isApproved == 1 ? "Yes" : "No",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplySection(ComplainBoxState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Replies",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              "(${state.selectedComplain?.replies?.length ?? 0})",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.selectedComplain?.replies?.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(height: 8.h,),
          itemBuilder: (context, index) {
            final item = state.selectedComplain?.replies![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item?.createdBy ?? "",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: item?.role == "Student"
                          ? AppColors.mainColor
                          : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "${NepaliDateTime.parse(item?.createdAt ?? "").day}-${NepaliDateTime.parse(item?.createdAt ?? "").month}-${NepaliDateTime.parse(item?.createdAt ?? "").year} ${NepaliDateTime.parse(item?.createdAt ?? "").hour}:${NepaliDateTime.parse(item?.createdAt ?? "").minute}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
            
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    item?.description ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
        
            // return ListTile(
            //   leading: Transform.flip(
            //     flipX: item?.role == "Student" ? false : true,
            //     child: Icon(
            //       Icons.reply,
            //       color: item?.role == "Student"
            //           ? AppColors.mainColor
            //           : Colors.green,
            //     ),
            //   ),
            //   title: Text(
            //     item?.createdBy ?? "",
            //     style: TextStyle(
            //       fontSize: 14.sp,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   subtitle: Text(
            //     item?.description ?? "",
            //     style: TextStyle(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // );
          },
        ),
      ],
    );
  }

  // Widget _buildSelectedRoleSection(ComplainBoxState state) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Selected Role",
  //         style: TextStyle(
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 8.h),
  //       Text(
  //         state.selectedRole?.name ?? "N/A",
  //         style: TextStyle(
  //           fontSize: 14.sp,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSelectedTeachersSection(ComplainBoxState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selected Teachers",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        state.selectedRoleUser.isEmpty
            ? Text(
                "N/A",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            : Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: state.selectedRoleUser
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          e.name ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildComplainDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complain Title",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _complainTitleController.text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Complain Description",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 100.h,
              maxHeight: 200.h
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: TextFormField(
              readOnly: true,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              controller: _complainDescriptionController,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Theme.of(context).cardColor),
          child: AlertDialog(
            content: Text(
              "Are you sure you want to delete this complain?",
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
                  BlocProvider.of<ComplainBoxCubit>(context).deleteComplain(
                    complainId: complainEntity!.id ?? 0,
                    onError: (error) {
                      CustomMethods().showSnackBar(
                        context,
                        error,
                        Colors.red,
                      );
                    },
                    onSuccess: () {
                      CustomMethods().showSnackBar(
                        context,
                        "Complain deleted successfully",
                        Colors.green,
                      );
                      Get.back();
                      Get.offNamedUntil(
                        AppPages.complainBox,
                        (route) => false,
                      );
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
