// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';

List<ClassModel> classModelFromJson(List str) =>
    List<ClassModel>.from(str.map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  int id;
  String name;
  String? shortName;
  int? rank;
  dynamic isClassTeacher;

  ClassModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.rank,
    required this.isClassTeacher,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
        rank: json["rank"],
        isClassTeacher: json["is_class_teacher"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
        "rank": rank,
        "is_class_teacher": isClassTeacher,
      };

  static List<ClassModel> fromListJson(data) {
    List<ClassModel> list = [];
    for (var item in data) {
      list.add(ClassModel.fromJson(item));
    }
    return list;
  }
}
