// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<TeacherSubjectModel> teachersubjectModelFromJson(List str) =>
    List<TeacherSubjectModel>.from(
        str.map((x) => TeacherSubjectModel.fromJson(x)));

String teachersubjectModelToJson(List<TeacherSubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherSubjectModel {
  int id;
  String name;
  int regularSubject;
  dynamic subjectCode;

  TeacherSubjectModel({
    required this.id,
    required this.name,
    required this.regularSubject,
    this.subjectCode,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) =>
      TeacherSubjectModel(
        id: json["id"],
        name: json["name"],
        regularSubject: json["regular_subject"],
        subjectCode: json["subject_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "regular_subject": regularSubject,
        "subject_code": subjectCode,
      };
}
