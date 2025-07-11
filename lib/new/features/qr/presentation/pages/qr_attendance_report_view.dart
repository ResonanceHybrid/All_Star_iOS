import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_state.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

import '../../../../../widgets/common_widgets/settings_popup_button.dart';

class QRSearchAttendancePage extends StatefulWidget {
  const QRSearchAttendancePage({
    super.key,
    required this.route,
  });
  final String route;

  @override
  State<QRSearchAttendancePage> createState() => _QRSearchAttendancePageState();
}

class _QRSearchAttendancePageState extends State<QRSearchAttendancePage> {
  CustomMethods cm = CustomMethods();

  String? selectedClass;
  String? selectedSection;
  String? selectedMonth;

  TextEditingController dateController = TextEditingController();
  final sc = Get.put(AppSearchController());

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QrCubit>(context).getScanTypes();
    dateController.text = picker.NepaliDateFormat("yyyy-MM-dd")
        .format(picker.NepaliDateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Attendance Report",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Get.toNamed(
              AppPages.teacherNavigation,
            );
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: const [
          SettingsPopupButton(),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        ),
      ),
      //drawer:.const TeacherDrawer(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          sc.refreshFunction();
        },
        child: GetX<AppSearchController>(
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
        
            if (sectionList.isNotEmpty && selectedSection == null) {
              selectedSection = sectionList
                  .firstWhereOrNull((element) => element.isClassTeacher == true)
                  ?.id
                  .toString();
            }
            if (monthList.isNotEmpty && selectedMonth == null) {
              selectedMonth = monthList
                  .firstWhere((element) => element.isCurrentMonth == 1)
                  .id
                  .toString();
            }
        
            return BlocBuilder<QrCubit, QrState>(
              builder: (context, qrState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type",
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
                            DropdownButtonFormField<QRAttendanceTypeEntity>(
                              itemHeight: 48.0,
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.red),
                                contentPadding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 10.0.w),
                                border: const OutlineInputBorder(),
                                hintStyle: TextStyle(
                                    fontFamily: "Lexend", fontSize: 12.sp),
                                filled: true,
                                enabled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              value: (qrState.selectedTypeList.isNotEmpty)
                                  ? qrState.selectedTypeList.first
                                  : null,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: qrState.scanTypesEntity?.map((dynamic value) {
                                return DropdownMenuItem<QRAttendanceTypeEntity>(
                                  value: value,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: qrState.scanTypesEntity!.indexOf(value) != 0 ? BorderSide(
                                          color: AppColors.colorsGrey300,
                                        ) : BorderSide.none,
                                      )
                                    ),
                                    child: Text(
                                      value.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.textDarkColorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  BlocProvider.of<QrCubit>(context)
                                      .selectScanType(
                                    value: val,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: qrState.selectedTypeList
                                  .map(
                                    (e) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.w),
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
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<QrCubit>(context)
                                                  .removeSelectedType(
                                                value: e,
                                              );
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 20.h),
                            SearchDropDown(
                              hintText: "Class",
                              data: classList,
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
                              data: sectionList,
                              onChanged: (val) {
                                setState(() {
                                  selectedSection = val;
                                });
                              },
                              value: selectedSection,
                            ),
                            SizedBox(height: 20.h),
                            SearchDropDown(
                              isMonth: true,
                              hintText: "Select Month",
                              data: monthList,
                              onChanged: (val) {
                                setState(() {
                                  selectedMonth = val;
                                });
                              },
                              value: selectedMonth,
                            ),
                            SizedBox(height: 50.h),
                            
                          ],
                        ),
                      ),
                    ),
                    KElevatedButton(
                      label: "Search",
                      onPressed: () {
                        if (qrState.selectedTypeList.isEmpty) {
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
                          cm.showSnackBar(context,
                              "Please select section", Colors.red);
                          return;
                        }
                    
                        if (selectedMonth == null) {
                          cm.showSnackBar(
                              context, "Please select month", Colors.red);
                          return;
                        }
                    
                        Get.toNamed(
                          widget.route,
                          arguments: {
                            "attendanceDate": dateController.text,
                            "attendanceTypes": qrState.selectedTypeList
                                .map((e) => e.id ?? 0)
                                .toList(),
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
            );
          },
        ),
      ),
    );
  }
}
