import 'package:all_star_learning/Pages/StudentPages/Fee/statement_widget.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:flutter/material.dart';

import '../../../Models/base_response_model.dart';
import '../../../Models/fee_model.dart';
import '../../../Resources/student_api_methods.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {

  @override
  void initState() {
    super.initState();
    getFeeData();
  }
  final cm = CustomMethods();

  bool isLoading = true;
  FeeModel? feeModel;
  String errorMessage = "";

  getFeeData() async {
    BaseResponse data = await StudentApiMethods.studentFeesData();
    if (data is SuccessResponse) {
      feeModel = FeeModel.fromJson(data.data);
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await getFeeData();
      },
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(context, "Statements"),
        body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != ""
            ? Center(
                child: Text(errorMessage),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                itemBuilder: (context, index) {
                  final Datum statement = feeModel!.data[index];
                  return StatementWidget(statement, highlight: true);
                }, 
                itemCount: feeModel?.data.length ?? 0
              ),
      ),
    );
  }
}