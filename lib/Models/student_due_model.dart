// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'dart:convert';

StudentDueModel dueModelFromJson(String str) => StudentDueModel.fromJson(json.decode(str));

class StudentDueModel {
  final double totalAssign;
  final double paid;
  final double totalAmount;
  final List<DueDetailsModel> details;

  StudentDueModel({
    required this.totalAssign,
    required this.paid,
    required this.totalAmount,
    required this.details,
  });

  factory StudentDueModel.fromJson(Map<String, dynamic> json) => StudentDueModel(
      totalAssign: double.tryParse(json["total_assign"].toString()) ?? 0.0,
      paid: double.tryParse(json["paid"].toString()) ?? 0.0, 
      totalAmount: double.tryParse(json["total_amt"].toString()) ?? 0.0,
      details: List<DueDetailsModel>.from(json["details"].map((x) => DueDetailsModel.fromJson(x))),
  );
}

class DueDetailsModel {
  final String type;
  final double amount;

  DueDetailsModel({
    required this.type,
    required this.amount,
  });

  factory DueDetailsModel.fromJson(Map<String, dynamic> json) => DueDetailsModel(
    type: json["type"],
    amount: double.tryParse(json["amt"].toString()) ?? 0.0,
  );
}
