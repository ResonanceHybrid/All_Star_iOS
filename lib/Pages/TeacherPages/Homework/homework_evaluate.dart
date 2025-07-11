import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
// import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/widgets/teacher/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class TeacherEvaluateHomeworkPage extends StatefulWidget {
  final int homeworkId;
  const TeacherEvaluateHomeworkPage({super.key, required this.homeworkId});

  @override
  State<TeacherEvaluateHomeworkPage> createState() =>
      _TeacherEvaluateHomeworkPageState();
}

class _TeacherEvaluateHomeworkPageState
    extends State<TeacherEvaluateHomeworkPage> {
  @override
  void initState() {
    super.initState();
    getStudentList();
  }

  getStudentList() async {
    setState(() {
      isLoadingHomework = true;
    });
    BaseResponse data = await ApiMethods.getHomeworkDetails(widget.homeworkId);

    if (data is SuccessResponse) {
      studentList = data.data["data"]["students"];
      // completedList = studentList
      //     .where((element) => element["is_completed"])
      //     .toList();
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something Went Wrong";
    }
    setState(() {
      isLoadingHomework = false;
    });
  }

  bool isLoadingHomework = false;
  String errorMessage = "";
  List studentList = [];

  TextEditingController evaluationDateController =
      TextEditingController(text: NepaliDateTime.now().format("yyyy-MM-dd"));

  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    var titleTextTheme = const TextStyle(
      fontSize: 13,
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: "Poppins",
    );

    // Theme.of(context).textTheme.titleLarge!.copyWith(
    //       color: AppColors.mainColor,
    //       fontWeight: FontWeight.w600,
    //     );
    var bodyTextTheme =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Evaluate Homework"),
      bottomNavigationBar: isLoadingHomework || errorMessage != ""
          ? const SizedBox()
          : GestureDetector(
              onTap: () async {
                await submitHomeworkEvaluate();
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.kGreenColor,
                ),
                child: Center(
                  child: Text(
                    "Submit",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TeacherContainerWidget(
          radius: 10,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: isLoadingHomework
                ? Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : studentList.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.40),
                          Center(
                            child: Text(
                              "No Data Found",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          TextFormField(
                            controller: evaluationDateController,
                            decoration: InputDecoration(
                              labelText: "Evaluation Day *",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.grey),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.mainColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.mainColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.mainColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Table(
                                  border: TableBorder.all(color: Colors.black),
                                  columnWidths: const {
                                    // 0: FixedColumnWidth(50),
                                    0: FixedColumnWidth(180),
                                    1: FixedColumnWidth(90),
                                    2: FixedColumnWidth(90),
                                    // 3: FixedColumnWidth(75),
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.all(2.0),
                                          //   child: Text(
                                          //     'S.N.',
                                          //     textAlign: TextAlign.center,
                                          //     style: titleTextTheme,
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              'Student Name',
                                              textAlign: TextAlign.center,
                                              style: titleTextTheme,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              'Completed',
                                              textAlign: TextAlign.center,
                                              style: titleTextTheme,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              'Pending',
                                              textAlign: TextAlign.center,
                                              style: titleTextTheme,
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 12),
                                          //   child: Text(
                                          //     'Details',
                                          //     textAlign: TextAlign.center,
                                          //     style: titleTextTheme,
                                          //   ),
                                          // ),
                                        ]),
                                    ...studentList.map(
                                      (e) {
                                        return TableRow(
                                          children: [
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(4.0),
                                            //   child: Text(
                                            //     " ${studentList.indexOf(e) + 1}",
                                            //     textAlign: TextAlign.center,
                                            //     style: bodyTextTheme,
                                            //   ),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 6,
                                                right: 6,
                                              ),
                                              child: Text(
                                                e["student_name"] ?? "N/A",
                                                textAlign: TextAlign.left,
                                                style: bodyTextTheme,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Radio(
                                                activeColor: Colors.green,
                                                value: e["is_completed"] ?? false,
                                                groupValue: true,
                                                onChanged: (value) {
                                                  e["is_completed"] = true;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Radio(
                                                activeColor: Colors.red,
                                                value: e["is_completed"] ?? false,
                                                groupValue: false,
                                                onChanged: (value) {
                                                  e["is_completed"] = false;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(4.0),
                                            //   child: e["file_submitted"] == true
                                            //     ? Center(
                                            //         heightFactor: 1.5,
                                            //         widthFactor: 1,
                                            //         child: GestureDetector(
                                            //           onTap: () {
                                            //             Get.toNamed(
                                            //                 AppPages
                                            //                     .teacherHomeworkDetailsView,
                                            //                 arguments: {
                                            //                   "homeworkId": widget
                                            //                       .homeworkId,
                                            //                   "userId":
                                            //                       e["user_id"],
                                            //                 });
                                            //           },
                                            //           child: const Icon(
                                            //             Icons.remove_red_eye,
                                            //             color:
                                            //                 AppColors.mainColor,
                                            //           ),
                                            //         ),
                                            //       )
                                            //     : Text(
                                            //         " ",
                                            //         textAlign: TextAlign.center,
                                            //         style: bodyTextTheme,
                                            //       ),
                                            //   ),
                                          ],
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  submitHomeworkEvaluate() async {
    cm.loadingAlertDialog();
    BaseResponse data = await ApiMethods.evaluateHomework(
      widget.homeworkId,
      studentList,
      evaluationDateController.text,
    );
    if (data is SuccessResponse) {
      Get.back();
      getStudentList();
      if (!mounted) return;
      cm.showSnackBar(
          context, "Homework evaluated successfully", AppColors.kGreenColor);
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something Went Wrong";
      Get.back();
      if (!mounted) return;
      cm.showSnackBar(context, errorMessage, AppColors.kRedColor);
    }
  }
}
