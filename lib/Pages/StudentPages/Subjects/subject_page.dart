import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  void initState() {
    super.initState();
    getStudentSubjects();
  }

  bool isLoading = true;
  String errorMessage = "";
  List<dynamic> subjectData = [];

  getStudentSubjects() async {
    BaseResponse data = await StudentApiMethods.getSubjects();
    if (data is SuccessResponse) {
      subjectData = data.data["data"];

      isLoading = false;
      setState(() {});
    } else if (data is ErrorResponse) {
      isLoading = false;
      errorMessage = data.message ?? "Something went wrong";
      setState(() {});
    }
  }

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Subjects"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              children: [
                isLoading
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
                        : subjectData.isEmpty
                            ? const SizedBox(
                                height: 300,
                                child: Center(
                                  child: Text("No Data Available"),
                                ),
                              )
                            : Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                },
                                border: TableBorder.all(
                                  width: 1, 
                                  color: Colors.black,
                                ),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.mainColor.withOpacity(0.2),
                                    ),
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text('S.N',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: AppColors.mainColor,
                                                )),
                                      ),
                                      Container(
                                        // alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Subjects',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...subjectData.map((e) {
                                    return TableRow(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                              "${subjectData.indexOf(e) + 1}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(e["name"] ?? "N/A",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
