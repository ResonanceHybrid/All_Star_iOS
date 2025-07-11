// To parse this JSON data, do
//
//     final studentHomeworkModel = studentHomeworkModelFromJson(jsonString);

import 'dart:convert';

StudentHomeworkModel studentHomeworkModelFromJson(String str) => StudentHomeworkModel.fromJson(json.decode(str));

String studentHomeworkModelToJson(StudentHomeworkModel data) => json.encode(data.toJson());

class StudentHomeworkModel {
    List<StudentHomework> studenthomeworkList;

    StudentHomeworkModel({
        required this.studenthomeworkList,
    });

    factory StudentHomeworkModel.fromJson(Map<String, dynamic> json) => StudentHomeworkModel(
        studenthomeworkList: List<StudentHomework>.from(json["homework"].map((x) => StudentHomework.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "homework": List<dynamic>.from(studenthomeworkList.map((x) => x.toJson())),
    };
}

class StudentHomework {
    int id;
    int classId;
    int sectionId;
    String className;
    String sectionName;
    String subjectName;
    String homeworkDate;
    String homeworkSubmissionDate;
    dynamic description;
    int submission;
    DateTime createdAt;
    List<HomeworkFiles> homeworkFiles;

    StudentHomework({
        required this.id,
        required this.classId,
        required this.sectionId,
        required this.className,
        required this.sectionName,
        required this.subjectName,
        required this.homeworkDate,
        required this.homeworkSubmissionDate,
        required this.description,
        required this.submission,
        required this.createdAt,
        required this.homeworkFiles,
    });

    factory StudentHomework.fromJson(Map<String, dynamic> json) => StudentHomework(
        id: json["id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        className: json["class_name"],
        sectionName: json["section_name"],
        subjectName: json["subject_name"],
        homeworkDate: json["homework_date"],
        homeworkSubmissionDate: json["homework_submission_date"],
        description: json["description"],
        submission: json["submission"],
        createdAt: DateTime.parse(json["created_at"]),
        homeworkFiles: List<HomeworkFiles>.from(json["homework_files"].map((x) => HomeworkFiles.fromJson(x))),

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "section_id": sectionId,
        "class_name": className,
        "section_name": sectionName,
        "subject_name": subjectName,
        "homework_date": homeworkDate,
        "homework_submission_date": homeworkSubmissionDate,
        "description": description,
        "submission": submission,
        "created_at": createdAt.toIso8601String(),
        "homework_files": List<dynamic>.from(homeworkFiles.map((x) => x.toJson())),
    };
}

class HomeworkFiles {
    int id;
    int homeworkId;
    String path;
    String? comments;

    HomeworkFiles({
        required this.id,
        required this.homeworkId,
        required this.path,
        required this.comments,
    });

    factory HomeworkFiles.fromJson(Map<String, dynamic> json) => HomeworkFiles(
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
    int id;
    int userId;
    String studentName;
    bool isCompleted;
    bool fileSubmitted;
    List<HomeworkFiles> files;

    Student({
        required this.id,
        required this.userId,
        required this.studentName,
        required this.isCompleted,
        required this.fileSubmitted,
        required this.files,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        userId: json["user_id"],
        studentName: json["student_name"],
        isCompleted: json["is_completed"],
        fileSubmitted: json["file_submitted"],
        files: List<HomeworkFiles>.from(json["files"].map((x) => HomeworkFiles.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "student_name": studentName,
        "is_completed": isCompleted,
        "file_submitted": fileSubmitted,
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
    };
}
