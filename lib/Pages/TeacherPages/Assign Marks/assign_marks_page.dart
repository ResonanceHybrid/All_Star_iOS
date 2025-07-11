import 'package:all_star_learning/Models/Search/assign_marks_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssignMarksPage extends StatefulWidget {
  final String examId;
  final String subjectId;
  final String sectionId;
  final String classId;
  final String examName;
  final String subjectName;
  final String sectionName;
  final String className;

  const AssignMarksPage(
      {super.key,
      required this.examId,
      required this.subjectId,
      required this.sectionId,
      required this.classId,
      required this.examName,
      required this.subjectName,
      required this.sectionName,
      required this.className});

  @override
  State<AssignMarksPage> createState() => _AssignMarksPageState();
}

class _AssignMarksPageState extends State<AssignMarksPage> {
  CustomMethods cm = CustomMethods();
  AssignMarksModel? assignMarks;
  bool isLoading = false;
  String error = '';

  int examSetupDetailId = -1;
  int theoryFullMarks = -1;
  int practicalFullMarks = -1;
  int totalFullMarks = -1;

  List<String?> theoryMarks = [];
  List<String?> practicalMarks = [];
  List<String?> studentIds = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> originalValues = {};

  getAssignedMarks() async {
    setState(() {
      isLoading = true;
      error = '';
      theoryMarks = [];
      practicalMarks = [];
      studentIds = [];
      originalValues = {};
    });
    BaseResponse response = await ApiMethods.getMarks(
      classId: Get.arguments['classId'],
      sectionId: Get.arguments['sectionId'],
      subjectId: Get.arguments['subjectId'],
      examId: Get.arguments['examId'],
    );

    if (response is SuccessResponse) {
      assignMarks = response.data as AssignMarksModel;
      examSetupDetailId = assignMarks?.subjectDetail.examSetupDetailId ?? -1;
      theoryFullMarks = assignMarks?.subjectDetail.thFm ?? -1;
      practicalFullMarks = assignMarks?.subjectDetail.prFm ?? -1;
      totalFullMarks = assignMarks?.subjectDetail.totalFm ?? -1;

      assignMarks?.studentDetail.forEach((student) {
        originalValues['${student.studentId}_theory'] = student.thMarks ?? '';
        originalValues['${student.studentId}_practical'] =
            student.prMarks ?? '';
      });
    } else {
      error = response.message ?? Strings.serverError;
    }

    setState(() {
      isLoading = false;
    });
  }

  setAssignedMarks() async {
    cm.loadingAlertDialog();
    BaseResponse response = await ApiMethods.setMarks(
      examSetupDetailId: examSetupDetailId.toString(),
      theoryMarks: theoryMarks,
      practicalMarks: practicalMarks,
      studentIds: studentIds,
    );

    if (response is SuccessResponse) {
      if (!mounted) return;
      cm.showSnackBar(context, response.data, Colors.green);
      Navigator.pop(context);
      await getAssignedMarks();
    } else {
      if (!mounted) return;
      Navigator.pop(context);

      cm.showSnackBar(
          context, response.message ?? Strings.serverError, Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    getAssignedMarks();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle kbodyTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(
          context,
          "Assign Marks",
          isBack: true,
        ),
        //drawer:.const TeacherDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            getAssignedMarks();
          },
          child: Stack(
            children: [
              isLoading
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
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24.0),
                          physics: const BouncingScrollPhysics(),
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
                                Text(
                                  widget.subjectName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kbodyTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Divider(),
                            const SizedBox(height: 12.0),
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
                            Table(
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
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(8),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(3),
                                4: FlexColumnWidth(3),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  children: [
                                    heading("#"),
                                    heading(
                                      "Student Name",
                                      isStudentName: true,
                                    ),
                                    heading("Theo\n($theoryFullMarks)"),
                                    heading("Prac\n($practicalFullMarks)"),
                                    heading("Total\n($totalFullMarks)",
                                    ),
                                  ],
                                ),
                                ...assignMarks!.studentDetail.map(
                                  (e) {
                                    return TableRow(
                                      children: [
                                        newBody(e.rollNo.toString()),
                                        newBody(
                                          e.name.toString(),
                                          isStudentName: true,
                                        ),
                                        theoryBody(
                                          e.thMarks.toString(),
                                          assignMarks!.studentDetail.indexOf(e),
                                        ),
                                        practicalBody(
                                          e.prMarks.toString(),
                                          assignMarks!.studentDetail.indexOf(e),
                                        ),
                                        e.totalMarks == null
                                          ? newBody("", isTotal: true)
                                          : newBody("${e.totalMarks}", isTotal: true),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
              // if (!(isLoading || error != ""))
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: ElevatedButton(
              //       onPressed: () async {
              //         if (_formKey.currentState!.validate()) {
              //           theoryMarks.clear();
              //           practicalMarks.clear();
              //           studentIds.clear();
              //           for (int i = 0;
              //               i < assignMarks!.studentDetail.length;
              //               i++) {
              //             theoryMarks
              //                 .add(assignMarks!.studentDetail[i].thMarks);
              //             practicalMarks
              //                 .add(assignMarks!.studentDetail[i].prMarks);
              //             studentIds.add(
              //               assignMarks?.studentDetail[i].studentId == null
              //                   ? null
              //                   : assignMarks!.studentDetail[i].studentId
              //                       .toString(),
              //             );
              //           }

              //           await setAssignedMarks();
              //         } else {
              //           CustomMethods().showToast(
              //             "One or more fields have invalid entry",
              //             Colors.red,
              //           );
              //         }
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: AppColors.mainColor,
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.zero,
              //         ),
              //       ),
              //       child: Text(
              //         "SUBMIT",
              //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        bottomNavigationBar: isLoading || error != ""
          ? const SizedBox()
          : KElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  theoryMarks.clear();
                  practicalMarks.clear();
                  studentIds.clear();
                  for (int i = 0;
                      i < assignMarks!.studentDetail.length;
                      i++) {
                    theoryMarks
                        .add(assignMarks!.studentDetail[i].thMarks);
                    practicalMarks
                        .add(assignMarks!.studentDetail[i].prMarks);
                    studentIds.add(
                      assignMarks?.studentDetail[i].studentId == null
                          ? null
                          : assignMarks!.studentDetail[i].studentId
                              .toString(),
                    );
                  }

                  await setAssignedMarks();
                } else {
                  CustomMethods().showToast(
                    "One or more fields have invalid entry",
                    Colors.red,
                  );
                }
              },
              label: "SUBMIT",
            ),
      ),
    );
  }

  heading(String title, {bool isStudentName = false, bool isTotal = false}) {
    return Container(
      alignment: isStudentName ? Alignment.centerLeft : Alignment.center,
      color: isTotal ? Colors.black.withOpacity(0.2) : null,
      padding: const EdgeInsets.all(5),
      child: Text(title,
          textAlign: isStudentName ? TextAlign.left : TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
    );
  }

  newBody(String body, {bool isTotal = false, isStudentName = false}) {
    TextEditingController controller = TextEditingController();
    controller.text = body;
    return Container(
      decoration:
          BoxDecoration(color: isTotal ? Colors.grey.withOpacity(0.2) : null),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        textAlign: isStudentName ? TextAlign.start : TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  theoryBody(String body, int index) {
    String studentId = assignMarks!.studentDetail[index].studentId.toString();
    String originalValue = originalValues['${studentId}_theory'] ?? '';

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:
            originalValue != body ? AppColors.mainColor.withOpacity(0.4) : null,
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
            assignMarks!.studentDetail[index].thMarks = value;
          });
        },
        validator: (value) {
          if (value == "null" || value == "") {
            return null;
          } else {
            double marks = double.tryParse(value!) ?? -1;
            if (marks == -1 || marks > theoryFullMarks) {
              return "Invalid";
            }
          }

          return null;
        },
      ),
    );
  }

  totalMarks(String body, int index) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        initialValue: body == "null" ? "" : body,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (value) {
          assignMarks!.studentDetail[index].thMarks = value;
        },
        validator: (value) {
          if (value == "null" || value == "") {
            return null;
          } else {
            double marks = double.tryParse(value!) ?? -1;
            if (marks == -1 || marks > theoryFullMarks) {
              CustomMethods().showToast(
                  // context,
                  "Theory marks should not be more than $theoryFullMarks",
                  Colors.red);
              return "Invalid";
            }
          }

          return null;
        },
      ),
    );
  }

  practicalBody(String body, int index) {
    String studentId = assignMarks!.studentDetail[index].studentId.toString();
    String originalValue = originalValues['${studentId}_practical'] ?? '';

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:
            originalValue != body ? AppColors.mainColor.withOpacity(0.4) : null,
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
          setState(() {
            assignMarks!.studentDetail[index].prMarks = value;
          });
        },
        validator: (value) {
          if (value == "null" || value == "") {
            return null;
          } else {
            double marks = double.tryParse(value!) ?? -1;
            if (marks == -1 || marks > practicalFullMarks) {
              CustomMethods().showToast(
                  // context,
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
