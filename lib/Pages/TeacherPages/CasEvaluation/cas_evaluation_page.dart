import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_static_colors.dart';

class CasEvaluationPage extends StatefulWidget {
  final String classId;
  final String sectionId;
  final String subjectId;
  final String? date;
  final String? monthId;
  final String reportType;

  const CasEvaluationPage({
    super.key,
    required this.classId,
    required this.sectionId,
    required this.subjectId,
    this.date,
    this.monthId,
    required this.reportType,
  });

  @override
  State<CasEvaluationPage> createState() => _CasEvaluationPageState();
}

class _CasEvaluationPageState extends State<CasEvaluationPage> {
  ApiMethods apiMethods = ApiMethods();
  Map<String, dynamic> cas = {};
  bool isLoading = false;
  String error = '';
  Map<String, dynamic> studentCasData = {};
  Map<String, dynamic> updatedCasData = {};

  String monthlyReportHtml = "";
  late String _reportType;

  @override
  void initState() {
    super.initState();
    _reportType = widget.reportType;
    if(widget.reportType == "monthly") {
      getMonthlyCasReport();
    } else {
      getCasEvaluation();
    }
  }

  Future<void> getCasEvaluation({bool load = true}) async {

    setState(() {
      isLoading = load;
      if(load) {
        cas = {};
      }
      error = '';
    });

    BaseResponse response = await apiMethods.getCasEvaluation(widget.classId, widget.sectionId, widget.subjectId, widget.date!);
    if (response is SuccessResponse) {
      setState(() {
        cas = response.data;
      });
    } else {
      // Handle error
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getMonthlyCasReport() async {
    setState(() {
      isLoading = true;
      monthlyReportHtml = "";
      error = '';
    });

    BaseResponse response = await apiMethods.getMonthlyCasReport(widget.classId, widget.sectionId, widget.subjectId, widget.monthId!);
    if (response is SuccessResponse) {
      setState(() {
        monthlyReportHtml = response.data;
      });
    } else {
      // Handle error
    }
    setState(() {
      isLoading = false;
    });
  }

  CustomMethods cm = CustomMethods();

  updateCasList({required String studentId, required String ecaId, required String marks}) {
    bool alreadySetup = false;
    for (var casData in studentCasData.entries) {
      if(casData.key == studentId.toString()) {
        Map<String, dynamic> eca = casData.value;
        if(eca.containsKey(ecaId.toString())) {
          eca[ecaId.toString()] = marks;
          alreadySetup = true;
          break;
        } else {
          eca.addEntries({
            ecaId.toString(): marks,
          }.entries);
          alreadySetup = true;
          break;
        }
      }
    }
    if(!alreadySetup) {
      studentCasData.addAll({
         studentId.toString(): {
          ecaId: marks,
        } 
      });
      updatedCasData = {
        "subject_id": cas["data"]["subject_id"].toString(),
        "date": cas["data"]["date"].toString(),
        "students": {
          ...studentCasData
        }
        
      };
    }
    setState(() {
      
    });
  }

  Future<void> storeCasEvaluation() async {
    if(updatedCasData.isEmpty) return;
    BaseResponse response = await apiMethods.storeCasEvaluation(casData: updatedCasData);
    if (response is SuccessResponse) {
      await getCasEvaluation(load: false);
      studentCasData.clear();
      updatedCasData.clear();
      cm.showToast(response.data["message"], Colors.green);
    } else {
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, 'CAS Evaluation'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : _reportType == "monthly" 
            ? _monthlyReport() 
            : _dateCasReport()
    );
  }

  Widget _dateCasReport() {
    return cas.isEmpty 
    ? const NoDataWidget() 
    : Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cas.isEmpty
              ? const NoDataWidget()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable2(
                      minWidth: 1000,
                      fixedLeftColumns: 2,
                      dataRowHeight: 55,
                      headingRowHeight: 55,
                      columnSpacing: 8,
                      lmRatio: 1.0,
                      smRatio: 0.35,
                      headingRowColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.2)),
                      border: TableBorder.symmetric(
                        outside: BorderSide(
                          width: 1,
                          color: Colors.grey.shade600,
                        ),
                        inside: BorderSide(
                          width: 1,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      columns: [
                        DataColumn2(
                          size: ColumnSize.S,
                          label: Text(
                            '#',
                            style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.M,
                          label: Text('Name',
                            style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                          ),
                        ),
                        ...cas["data"]["types"].map((e) {
                          return DataColumn2(
                            size: ColumnSize.L,
                            label: Text(
                              "${e["title"]} (${e["total_marks"]})",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                            )
                          );
                        })
                      ],
                      rows: [
                        ...cas["data"]["details"].map((student) {
                          List<dynamic> details = cas["data"]["details"];
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  "${details.indexOf(student) + 1}",
                                  style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge,
                                ),
                              ),
                              DataCell(
                                Text(
                                  student["name"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge,
                                ),
                              ),
                              ...student["types"].map((type) {
                                Map<String, dynamic>? cas = studentCasData.entries.where((element) => element.key == student["student_class_id"].toString()).firstOrNull?.value;
                                return DataCell(
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: cas?.containsKey(type["eca_setup_id"].toString()) == true && _formKey.currentState?.validate() == true ? AppColors.mainColor.withOpacity(0.4) : null,
                                    ),
                                    child: EcaTextField(
                                      totalMarks: double.tryParse(type["total_marks"]) ?? 0.0,
                                      value: type["obtained_marks"],
                                      onChanged: (value) {
                                        updateCasList(
                                          studentId: student["student_class_id"].toString(),
                                          ecaId: type["eca_setup_id"].toString(),
                                          marks: int.parse(value).toString(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              })
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: KElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    await storeCasEvaluation();
                  }
                }, 
                label: "Submit",
              ),
            )
          ],
        ),
    );
  }

  Widget _monthlyReport() {
    return monthlyReportHtml.isEmpty
      ? const NoDataWidget() 
      : InAppWebView(
          initialData: InAppWebViewInitialData(data: monthlyReportHtml),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              useOnLoadResource: true,
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
    );
  }
}

class EcaTextField extends StatefulWidget {
  final String? value;
  final void Function(String value)? onChanged;
  final double totalMarks;
  const EcaTextField({super.key, this.value, this.onChanged, required this.totalMarks,});

  @override
  State<EcaTextField> createState() => _EcaTextFieldState();
}

class _EcaTextFieldState extends State<EcaTextField> {
  late final TextEditingController _controller;
  late final double _totalMarks;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _totalMarks = widget.totalMarks;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration.collapsed(
        hintText: "",
      ),
      onChanged: (value) {
        if(value.isNotEmpty) {
          widget.onChanged!(value);
        }
      },
      validator: (String? val) {
        if (val == "null" || val == "") {
          return null;
        } else {
          double marks = double.tryParse(val!) ?? -1;

          if (marks == -1 || marks > _totalMarks) {
            return "Invalid";
          }
        }

        return null;
      },
    );
  }
}
