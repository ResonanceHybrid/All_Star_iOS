import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/exam_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  final String route;
  final String pageTitle;
  const SearchPage({super.key, required this.route, required this.pageTitle});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CustomMethods cm = CustomMethods();

  String? selectedExam;
  String? selectedSubject;
  String? selectedClass;
  String? selectedSection;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<AppSearchController>().teacherSubjects.clear();
      if (widget.route == AppPages.assignCAS) {
        Get.find<AppSearchController>().loadCASClasses();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppSearchController>(
      builder: (sc) {
        List<ExamModel> examList = sc.exams;
        List<ClassModel> classList = sc.classes;
        List<ClassModel> casClass = sc.cASClasses;
        List<SectionModel> sectionList = sc.sections;
        List<TeacherSubjectModel> teacherSubjectList = sc.teacherSubjects;

        bool isSubjectLoading = sc.isSubjectLoading.value;
        bool isSectionLoading = sc.isSectionLoading.value;

        if (sectionList.isNotEmpty && selectedSection == null) {
          selectedSection = sectionList[0].id.toString();
          if (selectedExam != null &&
              selectedClass != null &&
              selectedSection != null) {
            sc.loadSubjectsWithId(
              selectedClass!,
              selectedSection!,
              examId: selectedExam!,
            );
          }
        }
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
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      widget.route == AppPages.assignCAS
                          ? searchDropdown(
                              "Class",
                              casClass,
                              (val) async {
                                setState(() {
                                  selectedExam = null;
                                  selectedSection = null;
                                  selectedSubject = null;
                                  selectedClass = val;
                                });
              
                                await sc.loadExams(int.parse(selectedClass!));
                                await sc.loadSections(selectedClass!);
                              },
                              selectedClass,
                            )
                          : searchDropdown(
                              "Class",
                              widget.route == AppPages.assignECA
                                  ? classList
                                      .where((element) =>
                                          element.isClassTeacher == true)
                                      .toList()
                                  : classList,
                              (val) async {
                                setState(() {
                                  selectedExam = null;
                                  selectedSection = null;
                                  selectedSubject = null;
                                  selectedClass = val;
                                });
                                await sc.loadExams(int.parse(selectedClass!));
                                await sc.loadSections(selectedClass!);
                              },
                              selectedClass,
                            ),
                      const SizedBox(height: 20),
                      searchDropdown(
                        "Section",
                        widget.route == AppPages.assignECA
                            ? sectionList
                                .where(
                                    (element) => element.isClassTeacher == true)
                                .toList()
                            : sectionList,
                        (val) {
                          setState(() {
                            selectedSubject = null;
                            selectedSection = val;
                          });
                          if (selectedExam != null &&
                              selectedClass != null &&
                              selectedSection != null) {
                            sc.loadSubjectsWithId(
                              selectedClass!,
                              selectedSection!,
                              examId: selectedExam!,
                            );
                          }
                        },
                        icon: isSectionLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const Icon(
                                Icons.arrow_downward,
                                color: AppColors.mainColor,
                              ),
                        selectedSection,
                      ),
                      const SizedBox(height: 20),
                      searchDropdown(
                        "Select Exam",
                        examList,
                        (val) {
                          setState(() {
                            selectedSubject = null;
                            selectedExam = val;
                          });
              
                          if (selectedExam != null &&
                              selectedClass != null &&
                              selectedSection != null) {
                            sc.loadSubjectsWithId(
                              selectedClass!,
                              selectedSection!,
                              examId: selectedExam!,
                            );
                          }
                        },
                        selectedExam,
                      ),
                      const SizedBox(height: 20),
                      widget.route != AppPages.assignECA
                          ? searchDropdown(
                              "Subject",
                              teacherSubjectList,
                              (val) {
                                setState(() {
                                  selectedSubject = val;
                                });
                              },
                              selectedSubject,
                              icon: isSubjectLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.arrow_downward,
                                      color: AppColors.mainColor,
                                    ),
                            )
                          : const SizedBox(),
                      SizedBox(height: 50.h),
                      // KElevatedButton(
                      //   onPressed: () async {
                      //     if (selectedExam == null ||
                      //         selectedClass == null ||
                      //         selectedSection == null ||
                      //         (widget.route != "/assignECA" &&
                      //             selectedSubject == null)) {
                      //       cm.showSnackBar(
                      //           context, "Please select all fields", Colors.red);
                      //       return;
                      //     }
              
                      //     Get.toNamed(
                      //       widget.route,
                      //       arguments: {
                      //         "examId": selectedExam,
                      //         "classId": selectedClass,
                      //         "sectionId": selectedSection,
                      //         "subjectId": selectedSubject,
                      //         "examName": examList
                      //             .firstWhere((element) =>
                      //                 element.id.toString() == selectedExam)
                      //             .name,
                      //         "className": classList
                      //             .firstWhere((element) =>
                      //                 element.id.toString() == selectedClass)
                      //             .name,
                      //         "sectionName": sectionList
                      //             .firstWhere((element) =>
                      //                 element.id.toString() == selectedSection)
                      //             .name,
                      //         "subjectName": selectedSubject != null
                      //             ? teacherSubjectList
                      //                 .firstWhere((element) =>
                      //                     element.id.toString() ==
                      //                     selectedSubject)
                      //                 .name
                      //             : "",
                      //       },
                      //     );
                      //   },
                      //   label: "Search",
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            bottomSheet: KElevatedButton(
              onPressed: () async {
                if (selectedExam == null ||
                    selectedClass == null ||
                    selectedSection == null ||
                    (widget.route != "/assignECA" &&
                        selectedSubject == null)) {
                  cm.showSnackBar(
                      context, "Please select all fields", Colors.red);
                  return;
                }
                    
                Get.toNamed(
                  widget.route,
                  arguments: {
                    "examId": selectedExam,
                    "classId": selectedClass,
                    "sectionId": selectedSection,
                    "subjectId": selectedSubject,
                    "examName": examList
                        .firstWhere((element) =>
                            element.id.toString() == selectedExam)
                        .name,
                    "className": classList
                        .firstWhere((element) =>
                            element.id.toString() == selectedClass)
                        .name,
                    "sectionName": sectionList
                        .firstWhere((element) =>
                            element.id.toString() == selectedSection)
                        .name,
                    "subjectName": selectedSubject != null
                        ? teacherSubjectList
                            .firstWhere((element) =>
                                element.id.toString() ==
                                selectedSubject)
                            .name
                        : "",
                  },
                );
              },
              label: "Search",
            ),
          ),
        );
      }
    );
  }

  searchDropdown(
    String hintText,
    List<dynamic> data,
    Function(dynamic) onChanged,
    String? dropdownValue, {
    Widget icon = const Icon(
      Icons.arrow_downward,
      color: AppColors.mainColor,
    ),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textDarkColorGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField(
          itemHeight: 48.0,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            errorStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
            border: const OutlineInputBorder(),
            hintStyle: TextStyle(fontFamily: "Lexend", fontSize: 12.sp),
            filled: true,
            enabled: false,
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
                color: Colors.red, // Set the error border color to amber
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: data.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value.id.toString(),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: data.indexOf(value) != 0 ? BorderSide(
                      color: AppColors.colorsGrey300,
                    ) : BorderSide.none,
                  )
                ),
                child: Text(
                  value.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.textDarkColorGrey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );

    // Container(
    //   padding: const EdgeInsets.only(left: 20, right: 10),
    //   decoration: BoxDecoration(boxShadow: const [
    //     BoxShadow(
    //       color: Colors.deepOrangeAccent,
    //       spreadRadius: 0,
    //       blurRadius: 5,
    //       offset: Offset(0, 5), // sets position of shadow
    //     ),
    //   ], color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15)),
    //   child: Theme(
    //     data: Theme.of(context).copyWith(
    //       canvasColor: Theme.of(context).cardColor,
    //     ),
    //     child: DropdownButtonFormField(
    //       value: dropdownValue,
    //       icon: icon,
    //       decoration: const InputDecoration(
    //         border: InputBorder.none,
    //       ),
    //       hint: Text(
    //         hintText,
    //         style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.mainColor, fontWeight: FontWeight.w600),
    //       ),
    //       alignment: Alignment.centerLeft,
    //       items: data.map((dynamic value) {
    //         return DropdownMenuItem<dynamic>(
    //           value: value.id.toString(),
    //           child: Text(value.name, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.mainColor, fontWeight: FontWeight.w600)),
    //         );
    //       }).toList(),
    //       onChanged: onChanged,
    //     ),
    //   ),
    // );
  }
}
