// To parse this JSON data, do
//
//     final feeModel = feeModelFromJson(jsonString);

import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
  final Map<String, dynamic> summary;
  final List<Datum> data;

  FeeModel({
      required this.summary,
      required this.data,
  });

  factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
      summary: json["summary"],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String month;
  final String type;
  final int totalAmount;
  final String date;
  final String? paymentMode;

  Datum({
    required this.id,
    required this.month,
    required this.type,
    required this.totalAmount,
    required this.date,
    required this.paymentMode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    month: json["month"],
    type: json["type"],
    totalAmount: json["total_amount"],
    date: json["date"],
    paymentMode: json["payment_mode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "month": month,
    "type": type,
    "total_amount": totalAmount,
    "date": date,
    "payment_mode": paymentMode,
  };

}
