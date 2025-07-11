// To parse this JSON data, do
//
//     final homeworkListModel = homeworkListModelFromJson(jsonString);

import 'dart:convert';

HomeworkListModel homeworkListModelFromJson(String str) => HomeworkListModel.fromJson(json.decode(str));

String homeworkListModelToJson(HomeworkListModel data) => json.encode(data.toJson());

class HomeworkListModel {
    List<HomeWork>? homeworkList;
    String? message;

    HomeworkListModel({
        this.homeworkList,
        this.message,
    });

    factory HomeworkListModel.fromJson(Map<String, dynamic> json) => HomeworkListModel(
        homeworkList: json["data"] == null ? [] : List<HomeWork>.from(json["data"]!.map((x) => HomeWork.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": homeworkList == null ? [] : List<dynamic>.from(homeworkList!.map((x) => x.toJson())),
        "message": message,
    };
}

class HomeWork {
    int? id;
    int? classId;
    int? sectionId;
    String? className;
    String? sectionName;
    String? subjectName;
    DateTime? homeworkDate;
    DateTime? homeworkSubmissionDate;
    String? description;
    int? submission;
    DateTime? createdAt;
    List<HomeworkFileElement>? homeworkFiles;
    List<Student>? students;

    HomeWork({
        this.id,
        this.classId,
        this.sectionId,
        this.className,
        this.sectionName,
        this.subjectName,
        this.homeworkDate,
        this.homeworkSubmissionDate,
        this.description,
        this.submission,
        this.createdAt,
        this.homeworkFiles,
        this.students,
    });

    factory HomeWork.fromJson(Map<String, dynamic> json) => HomeWork(
        id: json["id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        className: json["class_name"],
        sectionName: json["section_name"],
        subjectName: json["subject_name"],
        homeworkDate: json["homework_date"] == null ? null : DateTime.parse(json["homework_date"]),
        homeworkSubmissionDate: json["homework_submission_date"] == null ? null : DateTime.parse(json["homework_submission_date"]),
        description: json["description"],
        submission: json["submission"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        homeworkFiles: json["homework_files"] == null ? [] : List<HomeworkFileElement>.from(json["homework_files"]!.map((x) => HomeworkFileElement.fromJson(x))),
        students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "section_id": sectionId,
        "class_name": className,
        "section_name": sectionName,
        "subject_name": subjectName,
        "homework_date": "${homeworkDate!.year.toString().padLeft(4, '0')}-${homeworkDate!.month.toString().padLeft(2, '0')}-${homeworkDate!.day.toString().padLeft(2, '0')}",
        "homework_submission_date": "${homeworkSubmissionDate!.year.toString().padLeft(4, '0')}-${homeworkSubmissionDate!.month.toString().padLeft(2, '0')}-${homeworkSubmissionDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "submission": submission,
        "created_at": createdAt?.toIso8601String(),
        "homework_files": homeworkFiles == null ? [] : List<dynamic>.from(homeworkFiles!.map((x) => x.toJson())),
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
    };
}

class HomeworkFileElement {
    int? id;
    int? homeworkId;
    String? path;
    String? comments;

    HomeworkFileElement({
        this.id,
        this.homeworkId,
        this.path,
        this.comments,
    });

    factory HomeworkFileElement.fromJson(Map<String, dynamic> json) => HomeworkFileElement(
        id: json["id"],
        homeworkId: json["homework_id"],
        path: json["path"],
        comments: json["comments"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "homework_id": homeworkId,
        "path": path,
        "comments": comments,
    };
}

class Student {
    int? id;
    int? userId;
    String? studentName;
    bool? isCompleted;
    bool? fileSubmitted;
    List<HomeworkFileElement>? files;

    Student({
        this.id,
        this.userId,
        this.studentName,
        this.isCompleted,
        this.fileSubmitted,
        this.files,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        userId: json["user_id"],
        studentName: json["student_name"],
        isCompleted: json["is_completed"],
        fileSubmitted: json["file_submitted"],
        files: json["files"] == null ? [] : List<HomeworkFileElement>.from(json["files"]!.map((x) => HomeworkFileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "student_name": studentName,
        "is_completed": isCompleted,
        "file_submitted": fileSubmitted,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
    };
}
