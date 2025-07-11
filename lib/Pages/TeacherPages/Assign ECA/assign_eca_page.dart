import 'dart:developer';
import 'package:all_star_learning/Models/assing_eca_marks_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/local_storage.dart';

class AssignEcaMarksPage extends StatefulWidget {
  final String examId;
  final String sectionId;
  final String classId;
  final String examName;
  final String sectionName;
  final String className;

  const AssignEcaMarksPage(
      {super.key,
      required this.examId,
      required this.sectionId,
      required this.classId,
      required this.examName,
      required this.sectionName,
      required this.className});

  @override
  State<AssignEcaMarksPage> createState() => _AssignEcaMarksPageState();
}

class _AssignEcaMarksPageState extends State<AssignEcaMarksPage> {
  CustomMethods cm = CustomMethods();
  AssignEcaMarksModel? assignEcaMarks;
  bool isLoading = false;
  String error = '';

  int examSetupDetailId = -1;
  int theoryFullMarks = -1;
  int practicalFullMarks = -1;
  int totalFullMarks = -1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> originalValues = {};

  getAssignedEca() async {
    setState(() {
      isLoading = true;
      error = '';
    });
    BaseResponse response = await ApiMethods.getEcaMarks(
      examId: widget.examId,
      sectionId: widget.sectionId,
      classId: widget.classId,
    );

    if (response is SuccessResponse) {
      assignEcaMarks = await compute<Map<String, dynamic>, AssignEcaMarksModel>(
          assignEcaMarksModelFromJson, response.data);
      examSetupDetailId = assignEcaMarks!.examSetupId;

      // Save original values
      for (var student in assignEcaMarks!.studentEcaDetails) {
        for (var ecaDetail in student.ecaDetails) {
          originalValues['${student.studentId}_${ecaDetail.ecaId}'] =
              ecaDetail.marks.toString();
        }
        originalValues['${student.studentId}_attendance'] =
            student.attendanceDays.toString();
      }
    } else {
      error = response.message ?? Strings.serverError;
    }
    setState(() {
      isLoading = false;
    });
  }

  setAssignedEcaMarks() async {
    cm.loadingAlertDialog();
    Map ecaMarks = {};
    Map totalAttendance = {};
    for (var element in assignEcaMarks!.studentEcaDetails) {
      ecaMarks[element.studentId.toString()] = {};

      for (var element1 in element.ecaDetails) {
        ecaMarks[element.studentId.toString()][element1.ecaId.toString()] =
            element1.marks.toString();
      }
      totalAttendance[element.studentId.toString()] =
          element.attendanceDays.toString();
    }
    log(totalAttendance.toString());
    log(examSetupDetailId.toString());

    BaseResponse response = await ApiMethods.setEcaMarks(
      ecaMarks: ecaMarks,
      examSetupDetailId: examSetupDetailId.toString(),
      totalAttendance: totalAttendance,
    );

    if (response is SuccessResponse) {
      if (!mounted) return;
      cm.showSnackBar(context, response.data, Colors.green);
      Navigator.pop(context);
      await getAssignedEca();
    } else {
      if (!mounted) return;

      Navigator.pop(context);
      if (!mounted) return;

      cm.showSnackBar(
          context, response.message ?? Strings.serverError, Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    getAssignedEca();
  }

  @override
  Widget build(BuildContext context) {
    bool role = LocalStorageMethods.getUserDetails()["data"]
            ["is_class_teacher"] ??
        false;
    TextStyle kbodyTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(context, "Assign ECA Marks"),
        body: RefreshIndicator(
          onRefresh: () async {
            getAssignedEca();
          },
          child: SafeArea(
            child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : error != ""
                  ? Container(
                      margin: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(error,
                          textAlign: TextAlign.center,
                          style: kbodyTextStyle,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.examName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kbodyTextStyle,
                                  ),
                                  Text(
                                    widget.className,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kbodyTextStyle,
                                  ),
                                  Text(
                                    widget.sectionName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kbodyTextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fill Marks",
                                    style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  ),
                                  Text(
                                    "Leave blank if absent",
                                    style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color:AppColors.mainColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DataTable2(
                              minWidth: assignEcaMarks!.examEcas.isEmpty ? null : 1000,
                              fixedLeftColumns: 2,
                              dataRowHeight: 55,
                              headingRowHeight: 55,
                              columnSpacing: 8,
                              lmRatio: 1.0,
                              smRatio: 0.35,
                              horizontalMargin: 6.0,
                              headingRowColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.2)),
                              border: TableBorder.symmetric(
                                inside: const BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                outside: const BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              columns: [
                                newHeading("S.N", columnSize: ColumnSize.S),
                                newHeading(
                                  "Student Name", 
                                  isStudentName: true, 
                                  columnSize: ColumnSize.L,
                                  canOverflow: true,
                                ),
                                ...assignEcaMarks!.examEcas.map((e) {
                                  return newHeading(
                                    "${e.ecaTitle}\n(${e.fullMarks})",
                                    canOverflow: true,
                                  );
                                }),
                                if (role)
                                  newHeading(
                                    "Attendance (${assignEcaMarks?.totalAttendance})",
                                  )
                              ],
                              rows: [
                                ...assignEcaMarks!.studentEcaDetails.map((e) {
                                  return DataRow(
                                    cells: [
                                      newBody(e.rollNo.toString()),
                                      newBody(e.name.toString(),isStudentName: true),
                                      ...assignEcaMarks!
                                          .studentEcaDetails[assignEcaMarks!.studentEcaDetails.indexOf(e)]
                                          .ecaDetails
                                          .map((e1) {
                                        return marksField(
                                          e1.marks.toString(),
                                          assignEcaMarks!.studentEcaDetails.indexOf(e),
                                          assignEcaMarks!.studentEcaDetails[assignEcaMarks!.studentEcaDetails.indexOf(e)].ecaDetails.indexOf(e1),
                                          int.parse(e1.fullMarks.toString()),
                                        );
                                      }),
                                      if (role)
                                        marksField(
                                          e.attendanceDays.toString(),
                                          assignEcaMarks!.studentEcaDetails.indexOf(e),
                                          assignEcaMarks!.studentEcaDetails[assignEcaMarks!.studentEcaDetails.indexOf(e)]
                                            .ecaDetails
                                            .length,
                                          assignEcaMarks!.totalAttendance,
                                          true,
                                        ),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
          ),
        ),
        bottomNavigationBar: isLoading || error != ""
          ? const SizedBox()
          : BottomAppBar(
              height: 60,
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.zero.copyWith(top: 8.0),
              child: KElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    for (int i = 0;
                        i < assignEcaMarks!.studentEcaDetails.length;
                        i++) {}
                              
                    await setAssignedEcaMarks();
                  } else {
                    CustomMethods().showToast(
                        "Invalid input in one or more field", Colors.red);
                  }
                },
                label: "SUBMIT",
              ),
            ),
      ),
    );
  }

  newHeading(String body, {
    bool isTotal = false, 
    isStudentName = false,
    ColumnSize columnSize = ColumnSize.L,
    bool canOverflow = false,
  }) {
    return DataColumn2(
      size: columnSize,
      fixedWidth: isStudentName ? 100 : null,
      label: Center(
        child: Text(
          body,
          textAlign: isStudentName ? TextAlign.start : TextAlign.center,
          maxLines: canOverflow ? 3 : 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.black,
            height: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  newBody(String body, {bool isTotal = false, isStudentName = false}) {
    return DataCell(
      Container(
        decoration: BoxDecoration(color: isTotal ? Colors.grey.withOpacity(0.2) : null),
        alignment: isStudentName ? Alignment.centerLeft : Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          body,
          textAlign: isStudentName ? TextAlign.left : TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            height: 1,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  marksField(String body, int studentIndex, int subjectIndex, int fullMarks,
      [bool isAttendance = false]) {
    return DataCell(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: originalValues['${assignEcaMarks!.studentEcaDetails[studentIndex].studentId}_${isAttendance ? 'attendance' : assignEcaMarks!.studentEcaDetails[studentIndex].ecaDetails[subjectIndex].ecaId}'] !=
            (isAttendance 
              ? assignEcaMarks!.studentEcaDetails[studentIndex].attendanceDays.toString()
              : assignEcaMarks!.studentEcaDetails[studentIndex].ecaDetails[subjectIndex].marks.toString())
                ? AppColors.mainColor.withOpacity(0.4)
                : null,
        ),
        child: TextFormField(
          initialValue: body == "null" ? "" : body,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (isAttendance) {
              setState(() {
                assignEcaMarks!.studentEcaDetails[studentIndex].attendanceDays =
                    int.parse(value);
              });
              return;
            }
            setState(() {
              assignEcaMarks!.studentEcaDetails[studentIndex]
                  .ecaDetails[subjectIndex].marks = value;
            });
          },
          validator: (value) {
            if (value == "null" || value == "") {
              return null;
            } else {
              double marks = double.tryParse(value!) ?? -1;
      
              if (marks == -1 || marks > fullMarks) {
                return "Invalid";
              }
            }
      
            return null;
          },
        ),
      ),
    );
  }

  practicalBody(String body, int index) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        initialValue: body,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (value) {
          assignEcaMarks!.studentEcaDetails[index].name = value;
        },
        validator: (value) {
          if (value == "null") {
            return null;
          } else {
            int marks = int.tryParse(value!) ?? -1;
            if (marks == -1 || marks > practicalFullMarks) {
              CustomMethods().showToast(
                  "Practical marks should not be more than $practicalFullMarks",
                  Colors.red);
              return "Invalid";
            }
          }

          return null;
        },
      ),
    );
  }
}
