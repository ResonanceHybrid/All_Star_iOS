// // To parse this JSON data, do
// //
// //     final studentExamListModel = studentExamListModelFromJson(jsonString);

// import 'dart:convert';

// StudentExamListModel studentExamListModelFromJson(String str) => StudentExamListModel.fromJson(json.decode(str));

// String studentExamListModelToJson(StudentExamListModel data) => json.encode(data.toJson());

// class StudentExamListModel {
//     bool success;
//     Map<String, List<StudentExamList>> data;
//     String message;

//     StudentExamListModel({
//         required this.success,
//         required this.data,
//         required this.message,
//     });

//     factory StudentExamListModel.fromJson(Map<String, dynamic> json) => StudentExamListModel(
//         success: json["success"],
//         data: Map.from(json["data"]).map((k, v) => MapEntry<String, List<StudentExamList>>(k, List<StudentExamList>.from(v.map((x) => StudentExamList.fromJson(x))))),
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
//         "message": message,
//     };
// }

// class StudentExamList {
//     int id;
//     String title;
//     String name;
//     String academicYearId;

//     StudentExamList({
//         required this.id,
//         required this.title,
//         required this.name,
//         required this.academicYearId,
//     });

//     factory StudentExamList.fromJson(Map<String, dynamic> json) => StudentExamList(
//         id: json["id"],
//         title: json["title"],
//         name: json["name"],
//         academicYearId: json["academic_year_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "name": name,
//         "academic_year_id": academicYearId,
//     };
// }
