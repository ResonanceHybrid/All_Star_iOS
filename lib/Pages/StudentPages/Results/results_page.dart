import 'dart:convert';
import 'dart:developer';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    getYear();
  }

  getResultList({required int academicYearId}) async {
    setState(() {
      isLoading = true;
      error = "";
    });
    BaseResponse response = await StudentApiMethods.getExamResultYearList(
      academicYearId: academicYearId,
    );
    if (response is SuccessResponse) {
      log(jsonEncode(response.data));
      examYearList = (response.data["data"] as List)
          .map((e) => ExamYearEntity.fromJson(e))
          .toList();
    } else if (response is ErrorResponse) {
      error = response.message ?? "Something went wrong";
    }
    setState(() {
      isLoading = false;
    });
  }

  getYear() async {
    setState(() {
      isLoading = true;
      error = "";
    });
    BaseResponse response = await StudentApiMethods.getYearList();
    if (response is SuccessResponse) {
      yearList = (response.data["data"] as List)
          .map((e) => YearEntity.fromJson(e))
          .toList();
      // Set default selected year to the first item if available
      if (yearList.isNotEmpty) {
        selectedYear = yearList[0].id ?? 0;
        // Fetch the result list for the default selected year
        getResultList(academicYearId: selectedYear!);
      }
    } else if (response is ErrorResponse) {
      error = response.message ?? "Something went wrong";
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = true;

  String error = "";

  List<ExamYearEntity> examYearList = [];
  List<YearEntity> yearList = [];

  int? selectedYear;

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Results"),
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ContainerWidget(
                      child: SizedBox(
                        height: 350,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : error.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContainerWidget(
                          child: SizedBox(
                            height: 350,
                            child: Center(child: Text(error)),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          // Dropdown to select year

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: SearchDropDown(
                              hintText: "Select Year",
                              value: selectedYear?.toString(),
                              data: yearList, 
                              name: (int? index) => yearList[index!].title!,
                              onChanged: (value) async {
                                setState(() {
                                  selectedYear = int.tryParse(value!);
                                });
                                getResultList(
                                  academicYearId: selectedYear!,
                                );
                              },
                            ),
                          ),

                          examYearList.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No data found",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: examYearList.isNotEmpty ? 1 : 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      ExamYearEntity examYear = examYearList[index];

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 10, right: 0),
                                        child: ContainerWidget(
                                            padding: 0,
                                            child: Column(
                                              children: [
                                                Table(
                                                  columnWidths: const {
                                                    0: FlexColumnWidth(2),
                                                    1: FlexColumnWidth(9),
                                                    2: FlexColumnWidth(2),
                                                  },
                                                  border: TableBorder.symmetric(
                                                    inside: const BorderSide(
                                                        width: 1,
                                                        color: Colors.black),
                                                  ),
                                                  children: [
                                                    TableRow(
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainColor
                                                            .withOpacity(0.1),
                                                      ),
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text('S.N',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                    color: AppColors
                                                                        .mainColor,
                                                                  )),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                            "${examYear.academicYearId} Examination",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                  color: AppColors
                                                                      .mainColor,
                                                                ),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                            '',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                  color: AppColors
                                                                      .mainColor,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ...examYearList
                                                        .map(
                                                          (e) => TableRow(
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                    (examYearList.indexOf(e) +
                                                                            1)
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge!),
                                                              ),
                                                              Tooltip(
                                                                message:
                                                                    e.name ??
                                                                        "N/A",
                                                                child:
                                                                    TextFormField(
                                                                        readOnly:
                                                                            true,
                                                                        initialValue:
                                                                            e.name ??
                                                                                "N/A",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          contentPadding:
                                                                              EdgeInsets.all(10),
                                                                        ),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyLarge!),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      AppPages
                                                                          .resultDetails,
                                                                      arguments:
                                                                          e.id);
                                                                },
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              12),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      FontAwesomeIcons
                                                                          .eye,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                        ,
                                                  ],
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}

class YearEntity {
  final int? id;
  final String? title;
  final String? slug;
  final String? createdAt;
  final int? isCollege;

  YearEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.createdAt,
    required this.isCollege,
  });

  factory YearEntity.fromJson(Map<String, dynamic> json) {
    return YearEntity(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      createdAt: json['created_at'],
      isCollege: json['is_college'],
    );
  }
}

class ExamYearEntity {
  final int? id;
  final String? name;
  final String? academicYearId;

  ExamYearEntity({
    required this.id,
    required this.name,
    required this.academicYearId,
  });

  factory ExamYearEntity.fromJson(Map<String, dynamic> json) {
    return ExamYearEntity(
      id: json['id'],
      name: json['name'],
      academicYearId: json['academic_year_id'],
    );
  }
}
