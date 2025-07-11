// To parse this JSON data, do
//
//     final AttendanceTypeModel = AttendanceTypeModelFromJson(jsonString);

import 'dart:convert';

List<AttendanceTypeModel> attendanceTypeModelFromJson(List str) =>
    List<AttendanceTypeModel>.from(
        str.map((x) => AttendanceTypeModel.fromJson(x)));

String attendanceTypeModelToJson(List<AttendanceTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceTypeModel {
  int id;
  String name;

  AttendanceTypeModel({
    required this.id,
    required this.name,
  });

  factory AttendanceTypeModel.fromJson(Map<String, dynamic> json) =>
      AttendanceTypeModel(
        id: json["id"],
        name: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
      };
}
