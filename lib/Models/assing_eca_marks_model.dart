// To parse this JSON data, do
//
//     final assignEcaMarksModel = assignEcaMarksModelFromJson(jsonString);

import 'dart:convert';

AssignEcaMarksModel assignEcaMarksModelFromJson(Map<String, dynamic> str) =>
    AssignEcaMarksModel.fromJson(str);

String assignEcaMarksModelToJson(AssignEcaMarksModel data) =>
    json.encode(data.toJson());


class AssignEcaMarksModel {
    int examSetupId;
    int totalAttendance;
    List<ExamEca> examEcas;
    List<StudentEcaDetail> studentEcaDetails;

    AssignEcaMarksModel({
        required this.examSetupId,
        required this.totalAttendance,
        required this.examEcas,
        required this.studentEcaDetails,
    });

    factory AssignEcaMarksModel.fromJson(Map<String, dynamic> json) => AssignEcaMarksModel(
        examSetupId: json["exam_setup_id"],
        totalAttendance: json["total_attendance"],
        examEcas: List<ExamEca>.from(json["exam_ecas"].map((x) => ExamEca.fromJson(x))),
        studentEcaDetails: List<StudentEcaDetail>.from(json["student_eca_details"].map((x) => StudentEcaDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "exam_setup_id": examSetupId,
        "total_attendance": totalAttendance,
        "exam_ecas": List<dynamic>.from(examEcas.map((x) => x.toJson())),
        "student_eca_details": List<dynamic>.from(studentEcaDetails.map((x) => x.toJson())),
    };
}

class ExamEca {
    int ecaId;
    String ecaTitle;
    int fullMarks;

    ExamEca({
        required this.ecaId,
        required this.ecaTitle,
        required this.fullMarks,
    });

    factory ExamEca.fromJson(Map<String, dynamic> json) => ExamEca(
        ecaId: json["eca_id"],
        ecaTitle: json["eca_title"],
        fullMarks: json["full_marks"],
    );

    Map<String, dynamic> toJson() => {
        "eca_id": ecaId,
        "eca_title": ecaTitle,
        "full_marks": fullMarks,
    };
}

class StudentEcaDetail {
    int studentId;
    int rollNo;
    String name;
    int attendanceDays;
    List<EcaDetail> ecaDetails;

    StudentEcaDetail({
        required this.studentId,
        required this.rollNo,
        required this.name,
        required this.attendanceDays,
        required this.ecaDetails,
    });

    factory StudentEcaDetail.fromJson(Map<String, dynamic> json) => StudentEcaDetail(
        studentId: json["student_id"],
        rollNo: json["roll_no"],
        name: json["name"],
        attendanceDays: json["attendance_days"],
        ecaDetails: List<EcaDetail>.from(json["eca_details"].map((x) => EcaDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "roll_no": rollNo,
        "name": name,
        "attendance_days": attendanceDays,
        "eca_details": List<dynamic>.from(ecaDetails.map((x) => x.toJson())),
    };
}

class EcaDetail {
    int ecaId;
    String ecaTitle;
    String fullMarks;
    String marks;

    EcaDetail({
        required this.ecaId,
        required this.ecaTitle,
        required this.fullMarks,
        required this.marks,
    });

    factory EcaDetail.fromJson(Map<String, dynamic> json) => EcaDetail(
        ecaId: json["eca_id"],
        ecaTitle: json["eca_title"],
        fullMarks: json["full_marks"],
        marks: json["marks"],
    );

    Map<String, dynamic> toJson() => {
        "eca_id": ecaId,
        "eca_title": ecaTitle,
        "full_marks": fullMarks,
        "marks": marks,
    };
}
