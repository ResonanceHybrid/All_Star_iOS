import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  void initState() {
    super.initState();
    getTeacherData();
  }

  CustomMethods cm = CustomMethods();

  List<dynamic> teacherList = [];
  String errorMessage = "";
  bool isLoading = true;

  getTeacherData() async {
    BaseResponse data = await StudentApiMethods.getTeachers();
    if (data is SuccessResponse) {
      teacherList = data.data["data"];
      isLoading = false;
      setState(() {});
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Teachers"),
      body: Container(
        height: 0.9.sh,
        margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10.0),
        child: isLoading
            ? const SizedBox(
                height: 300,
                child: Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                )),
              )
            : errorMessage != ""
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(errorMessage),
                    ),
                  )
                : teacherList.isEmpty
                    ? const SizedBox(
                        height: 300,
                        child: Center(
                          child: Text("No Data Available"),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(
                            width: 1, 
                            color: Colors.black,
                          ),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(3),
                            2: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: AppColors.mainColor.withOpacity(0.2),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "S.N",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.mainColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.mainColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Subjects",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.mainColor),
                                  ),
                                ),
                              ],
                            ),
                            ...teacherList.map((e) {
                              return TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        (teacherList.indexOf(e) + 1).toString(),
                                        style: TextStyle(
                                            color: e["is_class_teacher"] == true
                                                ? AppColors.mainColor
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e["teacher"] ?? "N/A",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color:
                                                      e["is_class_teacher"] ==
                                                              true
                                                          ? AppColors.mainColor
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .color),
                                        ),
                                        Text(
                                          e["is_class_teacher"] == true
                                              ? "(Class Teacher)"
                                              : "(Teacher)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color:
                                                      e["is_class_teacher"] ==
                                                              true
                                                          ? AppColors.mainColor
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .color),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e["subject"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color:
                                                  e["is_class_teacher"] == true
                                                      ? AppColors.mainColor
                                                      : Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .color),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
      ),
    );
  }
}

class Teacher {
  final String name;
  final String type;
  final String subjects;

  Teacher({required this.name, required this.type, required this.subjects});
}
