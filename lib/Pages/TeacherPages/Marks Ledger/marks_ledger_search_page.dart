import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/exam_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Pages/TeacherPages/Marks%20Ledger/marks_ledger_page.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarksLedgerSearchPage extends StatefulWidget {
  final String route;
  final String pageTitle;

  const MarksLedgerSearchPage({
    super.key,
    required this.route,
    required this.pageTitle,
  });

  @override
  State<MarksLedgerSearchPage> createState() => _MarksLedgerSearchPageState();
}

class _MarksLedgerSearchPageState extends State<MarksLedgerSearchPage> {
  CustomMethods cm = CustomMethods();
  ApiMethods apiMethods = ApiMethods();
  String htmlResponse = '';
  bool isLoading = false;
  String error = '';

  String? selectedClass;
  String? selectedSection;
  String? selectedExam;
  String? selectedMarksLedgerType = 'exam_result';

  List<MarksLedgerTypeModel> marksLedgerList = [
    const MarksLedgerTypeModel(
      id: 'exam_result',
      name: 'Exam Result',
    ),
    const MarksLedgerTypeModel(
      id: 'cas_result',
      name: 'CAS Result',
    ),
    const MarksLedgerTypeModel(
      id: 'eca_result',
      name: 'ECA Result',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        final sc = Get.put(AppSearchController());
        sc.refreshFunction();
      },
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(
          context,
          widget.pageTitle,
          isBack: true,
          isSearch: true,
        ),
        body: GetX<AppSearchController>(
          builder: (sc) {
            List<ClassModel> classList = sc.classes;
            List<SectionModel> sectionList = sc.sections;
            List<ExamModel> examList = sc.exams;
            if (sectionList.isNotEmpty && selectedSection == null) {
              selectedSection = sectionList.first.id.toString();
            }
      
            if (examList.isNotEmpty && selectedExam == null) {
              selectedExam = examList.first.id.toString();
            }
      
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  child: Column(
                    children: [
                      SearchDropDown(
                        hintText: "Select Class",
                        data: widget.route == AppPages.marksLedger
                            ? classList
                                .where((element) => element.isClassTeacher == true)
                                .toList()
                            : classList,
                        onChanged: (val) {
                          setState(() {
                            selectedClass = val;
                          });
                          sc.loadExams(int.parse(selectedClass!));
                          sc.loadSections(selectedClass!);
                        },
                        value: selectedClass,
                      ),
                      const SizedBox(height: 20),
                      SearchDropDown(
                        hintText: "Select Section",
                        data: widget.route == AppPages.marksLedger
                            ? sectionList
                                .where((element) => element.isClassTeacher == true)
                                .toList()
                            : sectionList,
                        onChanged: (val) {
                          setState(() {
                            selectedSection = val;
                          });
                        },
                        value: selectedSection,
                      ),
                      const SizedBox(height: 20),
                      SearchDropDown(
                        hintText: "Select Type",
                        data: marksLedgerList,
                        onChanged: (val) {
                          setState(() {
                            selectedMarksLedgerType = val;
                          });
                        },
                        value: selectedMarksLedgerType,
                      ),
                      const SizedBox(height: 20),
                      SearchDropDown(
                        hintText: "Select Exam",
                        data: examList,
                        value: selectedExam,
                        onChanged: (val) {
                          setState(() {
                            selectedExam = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                KElevatedButton(
                  label: "Search",
                  onPressed: () async {
                    if (selectedMarksLedgerType == null) {
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
                    if (selectedExam == null) {
                      cm.showSnackBar(
                          context, "Please select exam", Colors.red);
                      return;
                    }
                          
                    Get.toNamed(widget.route, arguments: {
                      'class_id': selectedClass,
                      'section_id': selectedSection,
                      'exam_id': selectedExam,
                      'type': selectedMarksLedgerType,
                      "class_name": classList
                          .firstWhere((element) =>
                              element.id.toString() == selectedClass)
                          .name,
                      "section_name": sectionList
                          .firstWhere((element) =>
                              element.id.toString() == selectedSection)
                          .name,
                      "exam_name": examList
                          .firstWhere((element) =>
                              element.id.toString() == selectedExam)
                          .name,
                      "ledger_exam_type": marksLedgerList
                          .firstWhere((element) =>
                              element.id.toString() ==
                              selectedMarksLedgerType)
                          .name
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
