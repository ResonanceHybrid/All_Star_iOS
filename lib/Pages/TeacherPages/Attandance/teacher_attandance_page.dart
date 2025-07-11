import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/attendance_data_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class TeacherAttendancePage extends StatefulWidget {
  final String attendanceDate;
  final String selectedClass;
  final String selectedSection;
  final String selectedType;
  final List<ClassModel> classList;
  final List<SectionModel> sectionList;
  const TeacherAttendancePage({
    super.key,
    required this.attendanceDate,
    required this.selectedType,
    required this.selectedClass,
    required this.selectedSection,
    required this.classList,
    required this.sectionList,
  });

  @override
  State<TeacherAttendancePage> createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {
  CustomMethods cm = CustomMethods();

  // String? attendanceDate;
  // String? selectedClass;
  // String? selectedSection;
  List<StudentAttendanceModel>? attendanceData;
  // List<ClassModel>? classList;
  // List<SectionModel>? sectionList;

  @override
  void initState() {
    super.initState();
    getAttendance();
  }

  bool isChecked = false;
  bool isHoliday = false;
  bool isLoading = false;
  bool markHoliday = false;

  List<String?> studentClassIds = [];
  List<int?> isPresentList = [];

  getAttendance() async {
    setState(() {
      isLoading = true;
      attendanceData = [];
      isPresentList = [];
    });
    BaseResponse response = await ApiMethods().getAttendanceDetails(
      widget.selectedClass,
      widget.selectedSection,
      widget.attendanceDate,
      widget.selectedType,
    );

    if (response is SuccessResponse) {
      attendanceData = studentAttendanceModelFromJson(response.data);
      for (var element in attendanceData!) {
        studentClassIds.add(element.studentClassId.toString());
        isPresentList.add(element.isPresent);
      }
    } else {
      if (!mounted) return;
      CustomMethods().showSnackBar(context, response.message!, Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  storeAttendance() async {
    CustomMethods().loadingAlertDialog();
    List filteredPresentList = [];
    List filteredStudentList = [];
    for (var i = 0; i < isPresentList.length; i++) {
      if (isPresentList[i] != null) {
        filteredPresentList.add(isPresentList[i]);
        filteredStudentList.add(studentClassIds[i]);
      } else {
        filteredPresentList.add(1);
        filteredStudentList.add(studentClassIds[i]);
      }
    }
    BaseResponse response = await ApiMethods.setAttendance(
      type: widget.selectedType,
      date: widget.attendanceDate,
      isPresent: filteredPresentList,
      studentClassIds: filteredStudentList,
      isHoliday: markHoliday,
    );
    if (!mounted) return;
    Navigator.pop(context);
    CustomMethods().showSnackBar(context, response.data!, Colors.green);
    getAttendance();

    if (response is SuccessResponse) {
    } else {
      if (!mounted) return;
      CustomMethods().showSnackBar(context, response.message!, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
    var bodyTextStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black);
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context,
        widget.attendanceDate,
        isBack: true,
      ),
      bottomNavigationBar: isLoading
          ? const SizedBox()
          : BottomAppBar(
              height: 60,
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.zero.copyWith(top: 8.0),
              child: KElevatedButton(
                onPressed: () async {
                  await storeAttendance();
                },
                
                label: "SUBMIT",
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Present: P",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Absent: A",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Mark Holiday",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.kOrangeColor,
                            value: markHoliday,
                            onChanged: (value) {
                              setState(() {
                                markHoliday = value ?? false;
                                isPresentList = List.generate(
                                  attendanceData!.length,
                                  (index) => value == true ? null : 1,
                                );
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                )
              ),
              child: Column(
                children: [
                  Container(
                    color: AppColors.mainColor.withOpacity(0.2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Roll No.",
                              textAlign: TextAlign.center,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Student Name",
                              textAlign: TextAlign.left,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.kGreenColor)),
                                child: const Text(
                                  "P",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.kRedColor)),
                                child: const Text(
                                  "A",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          ...attendanceData!.map((e) {
                            int? isPresent = isPresentList[attendanceData!.indexOf(e)];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          8.0,
                                        ),
                                        child: Text(
                                          e.rollNo.toString(),
                                          textAlign: TextAlign.center,
                                          style: bodyTextStyle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          8.0,
                                        ),
                                        child: Text(
                                          e.studentName.toString(),
                                          textAlign: TextAlign.left,
                                          style: bodyTextStyle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor: AppColors.kGreenColor,
                                              ),
                                              child: Radio<bool?>(
                                                groupValue: markHoliday
                                                  ? null
                                                  : isPresent == null
                                                    ? true
                                                    : isPresent == 0
                                                      ? false
                                                      : true,
                                                value: true,
                                                activeColor:AppColors.kGreenColor,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isPresentList[
                                                        attendanceData!
                                                            .indexOf(
                                                                e)] = value ==
                                                            true
                                                        ? 1
                                                        : 0;
                                                  });
                                                },
                                              ),
                                            ),
                                            Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor:
                                                    AppColors
                                                        .kRedColor,
                                              ),
                                              child: Radio<bool?>(
                                                groupValue: markHoliday
                                                    ? null
                                                    : isPresent == null
                                                        ? null
                                                        : isPresent == 0
                                                            ? false
                                                            : true,
                                                activeColor:
                                                    AppColors
                                                        .kRedColor,
                                                value: false,
                                                onChanged:
                                                    (bool? value) {
                                                  setState(() {
                                                    isPresentList[
                                                        attendanceData!
                                                            .indexOf(
                                                                e)] = value ==
                                                            true
                                                        ? 1
                                                        : 0;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                const Divider(),
                              ],
                            );
                          }),
                        ],
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
