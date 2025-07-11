// To parse this JSON data, do
//
//     final assignMarksModel = assignMarksModelFromJson(jsonString);

import 'dart:convert';

AssignMarksModel assignMarksModelFromJson(Map<String, dynamic> str) =>
    AssignMarksModel.fromJson(str);

String assignMarksModelToJson(AssignMarksModel data) =>
    json.encode(data.toJson());

class AssignMarksModel {
  SubjectDetail subjectDetail;
  List<StudentDetail> studentDetail;

  AssignMarksModel({
    required this.subjectDetail,
    required this.studentDetail,
  });

  factory AssignMarksModel.fromJson(Map<String, dynamic> json) =>
      AssignMarksModel(
        subjectDetail: SubjectDetail.fromJson(json["subject_detail"]),
        studentDetail: List<StudentDetail>.from(
            json["student_detail"].map((x) => StudentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subject_detail": subjectDetail.toJson(),
        "student_detail":
            List<dynamic>.from(studentDetail.map((x) => x.toJson())),
      };
}

class StudentDetail {
  int studentId;
  int rollNo;
  String name;
  String? thMarks;
  String? prMarks;
  String? totalMarks;

  StudentDetail({
    required this.studentId,
    required this.rollNo,
    required this.name,
    this.thMarks,
    this.prMarks,
    this.totalMarks,
  });

  factory StudentDetail.fromJson(Map<String, dynamic> json) => StudentDetail(
        studentId: json["student_id"],
        rollNo: json["roll_no"],
        name: json["name"],
        thMarks: json["th_marks"],
        prMarks: json["pr_marks"],
        totalMarks: json["total_marks"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "roll_no": rollNo,
        "name": name,
        "th_marks": thMarks,
        "pr_marks": prMarks,
        "total_marks": totalMarks,
      };
}

class SubjectDetail {
  int examSetupDetailId;
  int thFm;
  int prFm;
  int totalFm;

  SubjectDetail({
    required this.examSetupDetailId,
    required this.thFm,
    required this.prFm,
    required this.totalFm,
  });

  factory SubjectDetail.fromJson(Map<String, dynamic> json) => SubjectDetail(
        examSetupDetailId: json["exam_setup_detail_id"],
        thFm: json["th_fm"],
        prFm: json["pr_fm"],
        totalFm: json["total_fm"],
      );

  Map<String, dynamic> toJson() => {
        "exam_setup_detail_id": examSetupDetailId,
        "th_fm": thFm,
        "pr_fm": prFm,
        "total_fm": totalFm,
      };
}
