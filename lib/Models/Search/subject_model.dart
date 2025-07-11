// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<SubjectModel> subjectModelFromJson(List str) =>
    List<SubjectModel>.from(str.map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
  int id;
  int classId;
  String name;

  SubjectModel({
    required this.id,
    required this.classId,
    required this.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json["id"],
        classId: json["class_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "name": name,
      };
}
