import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/attendance_type_model.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

class SearchAttendancePage extends StatefulWidget {
  final String route;
  final String pageTitle;

  const SearchAttendancePage(
      {super.key, required this.route, required this.pageTitle});

  @override
  State<SearchAttendancePage> createState() => _SearchAttendancePageState();
}

class _SearchAttendancePageState extends State<SearchAttendancePage> {
  CustomMethods cm = CustomMethods();

  String? selectedType;
  String? selectedClass;
  String? selectedSection;
  String? selectedMonth;

  TextEditingController dateController = TextEditingController();
  final sc = Get.put(AppSearchController());
  @override
  void initState() {
    super.initState();
    dateController.text = picker.NepaliDateFormat("yyyy-MM-dd")
        .format(picker.NepaliDateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        sc.refreshFunction();
      },
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(
          context,
          widget.pageTitle,
          isBack: true,
          isSearch: true,
        ),
        //drawer:.const TeacherDrawer(),
        body: GetX<AppSearchController>(
          builder: (sc) {
            List<ClassModel> classList = sc.classes;
            List<SectionModel> sectionList = sc.sections;
            List<MonthModel> monthList = [];
            for (MonthModel month in sc.months) {
              monthList.add(month);
              if (month.isCurrentMonth == 1) {
                break;
              }
            }
            List<AttendanceTypeModel> attendanceTypeList = sc.attendanceTypes;

            if (sectionList.isNotEmpty && selectedSection == null) {
              selectedSection = sectionList
                  .firstWhere((element) => element.isClassTeacher == true)
                  .id
                  .toString();
            }
            if (monthList.isNotEmpty && selectedMonth == null) {
              selectedMonth = monthList
                  .firstWhere((element) => element.isCurrentMonth == 1)
                  .id
                  .toString();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchDropDown(
                          hintText: "Type",
                          data: attendanceTypeList,
                          onChanged: (val) {
                            setState(() {
                              selectedType = val;
                            });
                          },
                          value: selectedType,
                        ),
                        SizedBox(height: 20.h),
                        SearchDropDown(
                          hintText: "Class",
                          data: widget.route == AppPages.teacherAttendance ||
                                  widget.route ==
                                      AppPages.teacherAttandanceReport
                              ? classList
                                  .where((element) =>
                                      element.isClassTeacher == true)
                                  .toList()
                              : classList,
                          onChanged: (val) {
                            setState(() {
                              selectedClass = val;
                            });
                            sc.loadSections(selectedClass!);
                          },
                          value: selectedClass,
                        ),
                        SizedBox(height: 20.h),
                        SearchDropDown(
                          hintText: "Section",
                          data: widget.route == AppPages.teacherAttendance ||
                                  widget.route ==
                                      AppPages.teacherAttandanceReport
                              ? sectionList
                                  .where((element) =>
                                      element.isClassTeacher == true)
                                  .toList()
                              : sectionList,
                          onChanged: (val) {
                            setState(() {
                              selectedSection = val;
                            });
                          },
                          value: selectedSection,
                        ),
                        SizedBox(height: 20.h),
                        widget.route != AppPages.teacherAttendance
                            ? SearchDropDown(
                                isMonth: true,
                                hintText: "Select Month",
                                data: monthList,
                                onChanged: (val) {
                                  setState(() {
                                    selectedMonth = val;
                                  });
                                },
                                value: selectedMonth,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Data",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: AppColors.textDarkColorGrey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black45,
                                      ),
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        picker
                                            .showMaterialDatePicker(
                                          context: context,
                                          initialDate: NepaliDateTime.now(),
                                          firstDate: NepaliDateTime(2000),
                                          lastDate: NepaliDateTime(2090),
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                dialogTheme: DialogThemeData(
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    shape:
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r))),
                                                primaryColor:
                                                    AppColors.mainColor,
                                                buttonTheme: const ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary // This will change to light theme.
                                                    ),
                                                colorScheme:
                                                    const ColorScheme.light(
                                                            primary: AppColors
                                                                .mainColor)
                                                        .copyWith(
                                                            secondary: AppColors
                                                                .mainColor),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        )
                                            .then((value) {
                                          if (value == null) return;
                                          setState(() {
                                            String month = value.month < 10
                                                ? "0${value.month}"
                                                : "${value.month}";
                                            String day = value.day < 10
                                                ? "0${value.day}"
                                                : "${value.day}";
                                            dateController.text =
                                                "${value.year}-$month-$day";
                                          });
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Select Date",
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.textLightDarkColorGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      autofocus: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Required field *";
                                        }
                                        return null;
                                      },
                                      controller: dateController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.textDarkColorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ),
                KElevatedButton(
                  label: "Search",
                  onPressed: () {
                    if (selectedType == null) {
                      cm.showSnackBar(
                          context, "Please select type", Colors.red);
                      return;
                    }
                    if (selectedClass == null) {
                      cm.showSnackBar(
                          context, "Please select class", Colors.red);
                      return;
                    }
                    if (selectedSection == null) {
                      cm.showSnackBar(
                          context, "Please select section", Colors.red);
                      return;
                    }

                    if (dateController.text.isEmpty &&
                        widget.route == AppPages.teacherAttendance) {
                      cm.showSnackBar(
                          context, "Please select date", Colors.red);
                      return;
                    }
                    if (selectedMonth == null &&
                        widget.route != AppPages.teacherAttendance) {
                      cm.showSnackBar(
                          context, "Please select month", Colors.red);
                      return;
                    }

                    Get.toNamed(
                      widget.route,
                      arguments: {
                        "attendanceDate": dateController.text,
                        "selectedType": selectedType,
                        "selectedClass": selectedClass,
                        "selectedSection": selectedSection,
                        "classList": classList,
                        "sectionList": sectionList,
                        "monthList": monthList,
                        "selectedMonth": selectedMonth,
                      },
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
