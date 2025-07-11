// To parse this JSON data, do
//
//     final examModel = examModelFromJson(jsonString);

import 'dart:convert';

List<ExamModel> examModelFromJson(List str) =>
    List<ExamModel>.from(str.map((x) => ExamModel.fromJson(x)));

String examModelToJson(List<ExamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamModel {
  int id;
  int academicYearId;
  String name;
  String rank;
  DateTime workingDaysFrom;
  DateTime workingDaysTo;
  String totalWorkingDays;
  String totalHolidays;
  int isActive;
  int createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  ExamModel({
    required this.id,
    required this.academicYearId,
    required this.name,
    required this.rank,
    required this.workingDaysFrom,
    required this.workingDaysTo,
    required this.totalWorkingDays,
    required this.totalHolidays,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        academicYearId: json["academic_year_id"],
        name: json["name"],
        rank: json["rank"],
        workingDaysFrom: DateTime.parse(json["working_days_from"]),
        workingDaysTo: DateTime.parse(json["working_days_to"]),
        totalWorkingDays: json["total_working_days"],
        totalHolidays: json["total_holidays"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "academic_year_id": academicYearId,
        "name": name,
        "rank": rank,
        "working_days_from":
            "${workingDaysFrom.year.toString().padLeft(4, '0')}-${workingDaysFrom.month.toString().padLeft(2, '0')}-${workingDaysFrom.day.toString().padLeft(2, '0')}",
        "working_days_to":
            "${workingDaysTo.year.toString().padLeft(4, '0')}-${workingDaysTo.month.toString().padLeft(2, '0')}-${workingDaysTo.day.toString().padLeft(2, '0')}",
        "total_working_days": totalWorkingDays,
        "total_holidays": totalHolidays,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
