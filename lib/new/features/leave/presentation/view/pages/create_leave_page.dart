import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class CreateLeavePage extends StatefulWidget {
  const CreateLeavePage({super.key});

  @override
  State<CreateLeavePage> createState() => _CreateLeavePageState();
}

class _CreateLeavePageState extends State<CreateLeavePage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _reasonController = TextEditingController();
  final _fromDateController = TextEditingController(
    text:
        "${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day}",
  );
  final _toDateController = TextEditingController(
    text:
        "${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day}",
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Create Leave'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                // Subject
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      KTextFormField(
                        topLabelText: "Subject",
                        topLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Leave Subject",
                        fillColor: const Color(0xFFdedfde),
                        controller: _subjectController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required field *";
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // Reason
                      KTextFormField(
                        topLabelText: "Reason",
                        topLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Leave Reason",
                        fillColor: const Color(0xFFdedfde),
                        controller: _reasonController,
                        keyboardType: TextInputType.text,
                        maxLines: 8,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required field *";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // From Date
                      Row(
                        children: [
                          SizedBox(
                            width: 0.43.sw,
                            child: KTextFormField(
                                topLabelText: "From Date",
                                topLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: "From Date",
                                fillColor: const Color(0xFFdedfde),
                                controller: _fromDateController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required field *";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _fromDateController.text =
                                        "${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day}";
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                onTap: () async {
                                  final date = await showMaterialDatePicker(
                                    context: context,
                                    initialDate: NepaliDateTime.now(),
                                    firstDate: NepaliDateTime(2000),
                                    lastDate: NepaliDateTime(2090),
                                    initialDatePickerMode: DatePickerMode.day,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          dialogTheme: DialogThemeData(
                                            surfaceTintColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          primaryColor: AppColors.mainColor,
                                          buttonTheme: const ButtonThemeData(
                                              textTheme: ButtonTextTheme
                                                  .primary // This will change to light theme.
                                              ),
                                          colorScheme: const ColorScheme.light(
                                                  primary: AppColors.mainColor)
                                              .copyWith(
                                            secondary: AppColors.mainColor,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (date == null) return;
                                  setState(() {
                                    String month = date.month < 10
                                        ? "0${date.month}"
                                        : "${date.month}";
                                    String day = date.day < 10
                                        ? "0${date.day}"
                                        : "${date.day}";
                                    _fromDateController.text =
                                        "${date.year}-$month-$day";
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 16.h,
                          ),
                          // To Date
                          SizedBox(
                            width: 0.43.sw,
                            child: KTextFormField(
                                topLabelText: "To Date",
                                topLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: "To Date",
                                fillColor: const Color(0xFFdedfde),
                                controller: _toDateController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required field *";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _toDateController.text =
                                        "${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day}";
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                onTap: () async {
                                  final date = await showMaterialDatePicker(
                                    context: context,
                                    initialDate: NepaliDateTime.now(),
                                    firstDate: NepaliDateTime(2000),
                                    lastDate: NepaliDateTime(2090),
                                    initialDatePickerMode: DatePickerMode.day,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          dialogTheme: DialogThemeData(
                                            surfaceTintColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          primaryColor: AppColors.mainColor,
                                          buttonTheme: const ButtonThemeData(
                                              textTheme: ButtonTextTheme
                                                  .primary // This will change to light theme.
                                              ),
                                          colorScheme: const ColorScheme.light(
                                                  primary: AppColors.mainColor)
                                              .copyWith(
                                            secondary: AppColors.mainColor,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (date == null) return;
                                  setState(() {
                                    String month = date.month < 10
                                        ? "0${date.month}"
                                        : "${date.month}";
                                    String day = date.day < 10
                                        ? "0${date.day}"
                                        : "${date.day}";
                                    _toDateController.text =
                                        "${date.year}-$month-$day";
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 16.h,
                ),
                // Submit Button
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<LeaveCubit>(context).createLeave(
                        subject: _subjectController.text,
                        reason: _reasonController.text,
                        fromDate: _fromDateController.text,
                        toDate: _toDateController.text,
                        onError: (error) {
                          CustomMethods()
                              .showSnackBar(context, error, Colors.red);
                        },
                        onSuccess: () {
                          CustomMethods().showSnackBar(
                              context, "Leave created", Colors.green);
                          _clearTextFields();
                          Get.back();
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
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
              ],
            ),
          ),
        );
      },
    );
  }

  void _clearTextFields() {
    _subjectController.clear();
    _reasonController.clear();
    _fromDateController.clear();
    _toDateController.clear();
  }
}
