import 'dart:developer';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:all_star_learning/Models/assign_cas_marks_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Pages/TeacherPages/TeacherDrawer/teacher_drawer.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/utils/custom_methods.dart';

class AssignCasMarksPage extends StatefulWidget {
  final String examId;
  final String sectionId;
  final String classId;
  final String subjectId;
  final String examName;
  final String sectionName;
  final String className;

  const AssignCasMarksPage({
    super.key,
    required this.examId,
    required this.sectionId,
    required this.classId,
    required this.examName,
    required this.sectionName,
    required this.className,
    required this.subjectId,
  });

  @override
  State<AssignCasMarksPage> createState() => _AssignCasMarksPageState();
}

class _AssignCasMarksPageState extends State<AssignCasMarksPage> {
  @override
  void initState() {
    super.initState();

    getAssignedCas();
    getCasTypes();
    getExamTypes();
  }

  CustomMethods cm = CustomMethods();
  AssignCasMarksModel? assignCasMarks;
  bool isLoading = false;
  String error = '';

  int examSetupDetailId = -1;
  int theoryFullMarks = -1;
  int practicalFullMarks = -1;
  int totalFullMarks = -1;

  Map<String, dynamic> casTypes = {
    "all": "Select CAS Type",
  };
  List<String> examTypes = [
    "Select Exam Type",
  ];
  Map<String, dynamic> examList = {
    "all": "Select Exam",
  };
  String _selectedCasType = "all";
  String _selectedExamType = "-1";
  String _selectedExam = "all";

  Map<String, String> originalValues = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getAssignedCas() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    BaseResponse response = await ApiMethods.getCasMarks(
      examId: widget.examId,
      sectionId: widget.sectionId,
      classId: widget.classId,
      subjectId: widget.subjectId,
    );

    if (response is SuccessResponse) {
      if (response.data != null) {
        assignCasMarks = response.data as AssignCasMarksModel;
        examSetupDetailId = assignCasMarks!.examSetupDetailId;

        for (var student in assignCasMarks!.studentCasDetails) {
        for (var ecaDetail in student.casDetails) {
          originalValues['${student.studentId}_${ecaDetail.casDetailId}'] =
              ecaDetail.marks.toString();
        }
        // originalValues['${student.studentId}_attendance'] =
        //     student.attendanceDays.toString();
      }
      } else {
        error = "NO Data Found";
      }
    } else if (response is ErrorResponse) {
      error = response.message ?? Strings.serverError;
    }

    setState(() {
      isLoading = false;
    });
  }

  setAssignedCasMarks() async {
    cm.loadingAlertDialog();
    Map ecaMarks = {};
    for (var element in assignCasMarks!.studentCasDetails) {
      ecaMarks[element.studentId.toString()] = {};
      for (var element1 in element.casDetails) {
        if (element1.marks != null) {
          ecaMarks[element.studentId.toString()]
              [element1.casDetailId.toString()] = element1.marks.toString();
        }
      }
    }
    log(ecaMarks.toString());
    BaseResponse response = await ApiMethods.setCasMarks(
      ecaMarks: ecaMarks,
      examSetupDetailId: examSetupDetailId.toString(),
    );

    if (response is SuccessResponse) {
      if (!mounted) return;
      cm.showSnackBar(context, response.data, Colors.green);
      Navigator.pop(context);
      await getAssignedCas();
    } else {
      if (!mounted) return;

      Navigator.pop(context);
      if (!mounted) return;

      cm.showSnackBar(
          context, response.message ?? Strings.serverError, Colors.red);
    }
  }

  resetDropdowns() {
    _selectedCasType = "all";
    _selectedExamType = "-1";
    _selectedExam = "all";
    casTypes = {
      "all": "Select CAS Type",
    };
    examTypes = [
      "Select Exam Type",
    ];
    examList = {
      "all": "Select Exam",
    };
    setState(() {});
  }

  getCasTypes() async {
    resetDropdowns();
    BaseResponse response = await ApiMethods.getCasTypes();

    if (response is SuccessResponse) {
      if (response.data != null) {
        casTypes = response.data;
        _selectedCasType = casTypes.keys.toList()[0];
        setState(() {});
        await getExamTypes();
      } else {}
    }
  }

  getExamTypes() async {
    BaseResponse response = await ApiMethods.getExamTypes();

    if (response is SuccessResponse) {
      if (response.data != null) {
        examTypes = response.data.cast<String>();
        _selectedExamType = examTypes[0];
        setState(() {});
        await getExamList();
      } else {}
    }
  }

  updateExamTypes({required String casType}) async {
    if (casType == "attendance") {
      examTypes = ["Normal"];
    } else {
      examTypes = ["Normal", "Merger"];
    }

    examTypes.toSet().toList();
    _selectedExamType = examTypes[0] == "Normal" ? "0" : "1";
  }

  getExamList() async {
    if (_selectedExamType == "-1" || _selectedCasType == "all") {
      return;
    }
    BaseResponse response = await ApiMethods.getExamsList(
      classId: widget.classId,
      type: _selectedExamType,
    );

    if (response is SuccessResponse) {
      if (response.data != null) {
        examList = response.data;
        _selectedExam = examList.keys.toList()[0];
        setState(() {});
      } else {}
    }
  }

  fetchUATMarks() async {
    setState(() {
      isLoading = true;
      error = '';
    });
    BaseResponse response = await ApiMethods.fetchUATMarks(
      examId: widget.examId,
      sectionId: widget.sectionId,
      classId: widget.classId,
      subjectId: widget.subjectId,
      casType: _selectedCasType,
      examIdForUT: _selectedExam,
      type: _selectedExamType,
    );

    if (response is SuccessResponse) {
      if (response.data != null && response.data.isNotEmpty) {
        assignCasMarks = assignCasMarksModelFromJson(response.data);
        examSetupDetailId = assignCasMarks!.examSetupDetailId;

        for (var student in assignCasMarks!.studentCasDetails) {
          for (var ecaDetail in student.casDetails) {
            originalValues['${student.studentId}_${ecaDetail.casDetailId}'] =
                ecaDetail.marks.toString();
          }
          // originalValues['${student.studentId}_attendance'] =
          //     student.attendanceDays.toString();
        }
      }
    } else if (response is ErrorResponse) {
      error = response.message ?? Strings.serverError;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle kbodyTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: AppColors.mainColor,
      fontWeight: FontWeight.bold,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(context, "Assign CAS Marks"),
        drawer: const TeacherDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            getAssignedCas();
          },
          child: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != ""
                    ? Container(
                        margin: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            error,
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
                                  children: [
                                    CASFilterDropdown(
                                      mapItems: casTypes,
                                      value: _selectedCasType,
                                      onChanged: (value) {
                                        updateExamTypes(casType: value.toString());
                                        setState(() {
                                          _selectedCasType = value.toString();
                                        });
                                        getExamList();
                                      },
                                    ),
                                    CASFilterDropdown(
                                      listItems: examTypes,
                                      value: _selectedExamType == "-1"
                                          ? "Select Exam Type"
                                          : _selectedExamType == "0"
                                              ? "Normal"
                                              : "Merge",
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedExamType =
                                              value.toString().toLowerCase() ==
                                                      "normal"
                                                  ? "0"
                                                  : "1";
                                        });
                                        getExamList();
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CASFilterDropdown(
                                      mapItems: examList,
                                      value: _selectedExam,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedExam = value.toString();
                                        });
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                      ),
                                      onPressed: () async {
                                        await fetchUATMarks();
                                      },
                                      child: const Text(
                                        "FILTER",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Fill Marks",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color:
                                                  AppColors.mainColor,
                                              fontWeight:
                                                  FontWeight.bold),
                                    ),
                                    Text(
                                      "Leave blank if absent",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color:
                                                  AppColors.mainColor,
                                              fontWeight:
                                                  FontWeight.normal),
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
                                minWidth: assignCasMarks!.casDetails.isEmpty ? null : 1000,
                                fixedLeftColumns: 2,
                                dataRowHeight: 55,
                                headingRowHeight: 72,
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
                                  ...assignCasMarks!.casDetails.map((e) {
                                    return newHeading(
                                      "${e.casTitle}(${e.fullMarks})",
                                      canOverflow: true,
                                    );
                                  }),
                                  newHeading(
                                    "Total\n(${assignCasMarks?.totalCasFullMarks ?? -1})",
                                  ),
                                ],
                                rows: [
                                  ...assignCasMarks!.studentCasDetails.map((e) {
                                    return DataRow(
                                      cells: [
                                        newBody(e.rollNo.toString()),
                                        newBody(e.name.toString(),isStudentName: true),
                                        ...assignCasMarks!
                                          .studentCasDetails[assignCasMarks!.studentCasDetails.indexOf(e)]
                                          .casDetails
                                          .map((e1) {
                                          return marksField(
                                            e1.marks.toString(),
                                            assignCasMarks!.studentCasDetails.indexOf(e),
                                            assignCasMarks!.studentCasDetails[ assignCasMarks!.studentCasDetails.indexOf(e)]
                                              .casDetails
                                              .indexOf(e1),
                                            e1.fullMarks,
                                          );
                                        }),
                                        newBody(e.totalCasMarks.toStringAsFixed(2))
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
          : KElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                for (int i = 0;
                    i < assignCasMarks!.studentCasDetails.length;
                    i++) {}
                          
                await setAssignedCasMarks();
              } else {
                CustomMethods().showSnackBar(
                  context,
                  "More or more field are have invalid entry",
                  Colors.red,
                );
              }
            },
            label: "SUBMIT",
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
          textAlign: isStudentName ? TextAlign.left : TextAlign.center,
          maxLines: canOverflow ? 3 : 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.black,
            height: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  newBody(String body, {bool isTotal = false, isStudentName = false}) {
    return DataCell(
      Container(
        decoration: BoxDecoration(
          color: isTotal 
            ? AppColors.mainColor.withOpacity(0.2) 
            : null,
        ),
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

  marksField(String body, int studentIndex, int subjectIndex, int fullMarks) {
    return DataCell(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: originalValues['${assignCasMarks!.studentCasDetails[studentIndex].studentId}_${ assignCasMarks!.studentCasDetails[studentIndex].casDetails[subjectIndex].casDetailId}'] !=
            assignCasMarks!.studentCasDetails[studentIndex].casDetails[subjectIndex].marks.toString()
              ? AppColors.mainColor.withOpacity(0.4)
              : null
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            setState(() {
              assignCasMarks!.studentCasDetails[studentIndex].casDetails[subjectIndex].marks = value;
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          assignCasMarks!.studentCasDetails[index].name = value;
        },
        validator: (value) {
          if (value == "null") {
            return null;
          } else {
            int marks = int.tryParse(value!) ?? -1;
            if (marks == -1 || marks > practicalFullMarks) {
              return "Invalid";
            }
          }

          return null;
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CASFilterDropdown extends StatelessWidget {
  final Map<String, dynamic>? mapItems;
  final List<String> listItems;
  final String value;
  int? flex;
  Function? onChanged;

  CASFilterDropdown({
    super.key,
    this.mapItems,
    required this.value,
    this.flex = 1,
    this.onChanged,
    this.listItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex!,
        child: Container(
          height: 35,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton(
            value: value,
            underline: const SizedBox(),
            isExpanded: true,
            items: mapItems != null
                ? mapItems!
                    .map((key, value) {
                      return MapEntry(
                        key,
                        DropdownMenuItem(
                          value: key,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList()
                : listItems.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    );
                  }).toList(),
            onChanged: (value) {
              onChanged!(value);
            },
          ),
        ));
  }
}
