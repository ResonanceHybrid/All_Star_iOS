// To parse this JSON data, do
//
//     final sectionModel = sectionModelFromJson(jsonString);

import 'dart:convert';

List<SectionModel> sectionModelFromJson(List str) =>
    List<SectionModel>.from(str.map((x) => SectionModel.fromJson(x)));

String sectionModelToJson(List<SectionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectionModel {
  int id;
  String name;
  bool isClassTeacher;

  SectionModel(
      {required this.id, required this.name, required this.isClassTeacher});

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        name: json["name"],
        isClassTeacher: json["is_class_teacher"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_class_teacher": isClassTeacher,
      };
}
