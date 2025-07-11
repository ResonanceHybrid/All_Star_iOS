// To parse this JSON data, do
//
//     final monthModel = monthModelFromJson(jsonString);

import 'dart:convert';

List<MonthModel> monthModelFromJson(List str) =>
    List<MonthModel>.from(str.map((x) => MonthModel.fromJson(x)));

String monthModelToJson(List<MonthModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonthModel {
    final int id;
    final String name;
    final String slug;
    final dynamic code;
    final int isCurrentMonth;

    MonthModel({
        required this.id,
        required this.name,
        required this.slug,
        this.code,
        required this.isCurrentMonth,
    });

    factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        code: json["code"],
        isCurrentMonth: json["is_current_month"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "code": code,
        "is_current_month": isCurrentMonth,
    };
}
