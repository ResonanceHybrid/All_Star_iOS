import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

class SearchCasEvaluationPage extends StatefulWidget {
  const SearchCasEvaluationPage({super.key});

  @override
  State<SearchCasEvaluationPage> createState() =>
      _SearchCasEvaluationPageState();
}

class _SearchCasEvaluationPageState extends State<SearchCasEvaluationPage> {
  CustomMethods cm = CustomMethods();

  String? selectedClass;
  String? selectedSection;
  String? selectedSubject;
  String? selectedMonth;
  String? selectedType;

  TextEditingController dateController = TextEditingController();
  final sc = Get.put(AppSearchController());
  @override
  void initState() {
    super.initState();
    Get.find<AppSearchController>().teacherSubjects.clear();
    dateController.text = picker.NepaliDateFormat("yyyy-MM-dd")
        .format(picker.NepaliDateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context,
        "CAS Evaluation",
        isBack: true,
        isSearch: true,
      ),
      body: GetX<AppSearchController>(
        builder: (sc) {
          List<ClassModel> classList = sc.classes;
          List<SectionModel> sectionList = sc.sections;
          List<TeacherSubjectModel> subjectList = sc.teacherSubjects;
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
          if (subjectList.isNotEmpty && selectedSection == null) {
            selectedSubject = subjectList.first.id.toString();
          }

          if (monthList.isNotEmpty) {
            selectedMonth = monthList
                .firstWhere((element) => element.isCurrentMonth == 1)
                .id
                .toString();
          }

          if (selectedClass != null &&
              selectedSection != null &&
              subjectList.isEmpty) {
            sc.loadSubjectsWithId(selectedClass!, selectedSection!);
          }

          return DefaultTabController(
            length: 2,
            child: Builder(builder: (context) {
              return Column(
                children: [
                  SizedBox(height: 16.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: AppColors.mainColor,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Cas Evaluation",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Monthly Report",
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        sc.refreshFunction();
                      },
                      child: TabBarView(
                        children: [
                          casEvaluationTab(classList, sectionList, subjectList),
                          monthlyReportTab(
                              classList, sectionList, subjectList, monthList),
                        ],
                      ),
                    ),
                  ),
                  KElevatedButton(
                    label: "Search",
                    onPressed: () {
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

                      if (selectedSubject == null) {
                        cm.showSnackBar(
                            context, "Please select subject", Colors.red);
                        return;
                      }

                      if (DefaultTabController.of(context).index == 0) {
                        if (dateController.text.isEmpty) {
                          cm.showSnackBar(
                              context, "Please select date", Colors.red);
                          return;
                        }
                      } else {
                        if (selectedMonth == null) {
                          cm.showSnackBar(
                              context, "Please select month", Colors.red);
                          return;
                        }
                      }

                      Get.toNamed(
                        "casEvaluation",
                        arguments: {
                          if (DefaultTabController.of(context).index == 0)
                            "date": dateController.text,
                          if (DefaultTabController.of(context).index == 1)
                            "month": selectedMonth,
                          "class": selectedClass,
                          "section": selectedSection,
                          "subject_id": selectedSubject,
                          "type": DefaultTabController.of(context).index == 0
                              ? "daily"
                              : "monthly",
                        },
                      );
                    },
                  )
                ],
              );
            }),
          );
        },
      ),
    );
  }

  Widget casEvaluationTab(
    List<ClassModel> classList,
    List<SectionModel> sectionList,
    List<TeacherSubjectModel> subjectList,
  ) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchDropDown(
              hintText: "Class",
              data: classList
                  .where((element) => element.isClassTeacher == true)
                  .toList(),
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
              data: sectionList
                  .where((element) => element.isClassTeacher == true)
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSection = val;
                });
              },
              value: selectedSection,
            ),
            SizedBox(height: 20.h),
            SearchDropDown(
              hintText: "Subject",
              data: subjectList,
              onChanged: (val) {
                setState(() {
                  selectedSubject = val;
                });
              },
              value: selectedSubject,
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Month",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.textDarkColorGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
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
                        initialDatePickerMode: DatePickerMode.day,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              dialogTheme: DialogThemeData(
                                surfaceTintColor: Colors.white,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              primaryColor: AppColors.mainColor,
                              buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme
                                    .primary, // This will change to light theme.
                              ),
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.mainColor,
                              ).copyWith(
                                secondary: AppColors.mainColor,
                              ),
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
                          String day =
                              value.day < 10 ? "0${value.day}" : "${value.day}";
                          dateController.text = "${value.year}-$month-$day";
                        });
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Select Date",
                      hintStyle: TextStyle(
                        color: AppColors.textLightDarkColorGrey,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }

  Widget monthlyReportTab(
    List<ClassModel> classList,
    List<SectionModel> sectionList,
    List<TeacherSubjectModel> subjectList,
    List<MonthModel> monthList,
  ) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchDropDown(
              hintText: "Class",
              data: classList
                  .where((element) => element.isClassTeacher == true)
                  .toList(),
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
              data: sectionList
                  .where((element) => element.isClassTeacher == true)
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSection = val;
                });
              },
              value: selectedSection,
            ),
            SizedBox(height: 20.h),
            SearchDropDown(
              hintText: "Subject",
              data: subjectList,
              onChanged: (val) {
                setState(() {
                  selectedSubject = val;
                });
              },
              value: selectedSubject,
            ),
            SizedBox(height: 20.h),
            SearchDropDown(
              hintText: "Month",
              isMonth: true,
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
    );
  }
}
