// To parse this JSON data, do
//
//     final studentAttendanceModel = studentAttendanceModelFromJson(jsonString);

import 'dart:convert';

List<StudentAttendanceModel> studentAttendanceModelFromJson(List str) =>
    List<StudentAttendanceModel>.from(
        str.map((x) => StudentAttendanceModel.fromJson(x)));

String studentAttendanceModelToJson(List<StudentAttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentAttendanceModel {
  int studentClassId;
  int rollNo;
  String studentName;
  dynamic isPresent;

  StudentAttendanceModel({
    required this.studentClassId,
    required this.rollNo,
    required this.studentName,
    this.isPresent,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceModel(
        studentClassId: json["student_class_id"],
        rollNo: json["roll_no"],
        studentName: json["student_name"],
        isPresent: json["is_present"],
      );

  Map<String, dynamic> toJson() => {
        "student_class_id": studentClassId,
        "roll_no": rollNo,
        "student_name": studentName,
        "is_present": isPresent,
      };
}
