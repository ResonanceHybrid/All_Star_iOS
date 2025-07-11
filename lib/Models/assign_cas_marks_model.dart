// To parse this JSON data, do
//
//     final assignCasMarksModel = assignCasMarksModelFromJson(jsonString);

import 'dart:convert';

AssignCasMarksModel assignCasMarksModelFromJson(Map<String, dynamic> str) =>
    AssignCasMarksModel.fromJson(str);

String assignCasMarksModelToJson(AssignCasMarksModel data) =>
    json.encode(data.toJson());

class AssignCasMarksModel {
  int examSetupDetailId;
  List<CasDetail> casDetails;
  List<StudentCasDetail> studentCasDetails;
  int totalCasFullMarks;

  AssignCasMarksModel({
    required this.examSetupDetailId,
    required this.casDetails,
    required this.studentCasDetails,
    required this.totalCasFullMarks,
  });

  factory AssignCasMarksModel.fromJson(Map<String, dynamic> json) =>
      AssignCasMarksModel(
        examSetupDetailId: json["exam_setup_detail_id"],
        totalCasFullMarks: json["total_cas_full_marks"],
        casDetails: List<CasDetail>.from(
            json["cas_details"].map((x) => CasDetail.fromJson(x))),
        studentCasDetails: List<StudentCasDetail>.from(
            json["student_cas_details"]
                .map((x) => StudentCasDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exam_setup_detail_id": examSetupDetailId,
        "total_cas_full_marks": totalCasFullMarks,
        "cas_details": List<dynamic>.from(casDetails.map((x) => x.toJson())),
        "student_cas_details":
            List<dynamic>.from(studentCasDetails.map((x) => x.toJson())),
      };
}

class CasDetail {
  int casDetailId;
  String casTitle;
  int fullMarks;
  dynamic marks;

  CasDetail({
    required this.casDetailId,
    required this.casTitle,
    required this.fullMarks,
    this.marks,
  });

  factory CasDetail.fromJson(Map<String, dynamic> json) => CasDetail(
        casDetailId: json["cas_detail_id"],
        casTitle: json["cas_title"],
        fullMarks: json["full_marks"],
        marks: json["marks"],
      );

  Map<String, dynamic> toJson() => {
        "cas_detail_id": casDetailId,
        "cas_title": casTitle,
        "full_marks": fullMarks,
        "marks": marks,
      };
}

class StudentCasDetail {
  int studentId;
  int rollNo;
  String name;
  num totalCasMarks;
  List<CasDetail> casDetails;

  StudentCasDetail({
    required this.studentId,
    required this.rollNo,
    required this.name,
    required this.casDetails,
    required this.totalCasMarks,
  });

  factory StudentCasDetail.fromJson(Map<String, dynamic> json) =>
      StudentCasDetail(
        studentId: json["student_id"],
        rollNo: json["roll_no"],
        name: json["name"],
        totalCasMarks: json["total_cas_marks"],
        casDetails: List<CasDetail>.from(
            json["cas_details"].map((x) => CasDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "roll_no": rollNo,
        "name": name,
        "total_cas_marks": totalCasMarks,
        "cas_details": List<dynamic>.from(casDetails.map((x) => x.toJson())),
      };
}
