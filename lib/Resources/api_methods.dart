import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:all_star_learning/Models/Search/assign_marks_model.dart';
import 'package:all_star_learning/Models/Search/attendance_type_model.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/exam_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/Search/subject_model.dart';
import 'package:all_star_learning/Models/assign_cas_marks_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/Resources/interceptor.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiMethods {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 100),
  ))
    ..interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    )
    ..interceptors.add(
      NetworkInterceptor(),
    );

  static login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(Strings.loginUrl, data: {
        "email": email,
        "password": password,
      });
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static updatePassword({required int userId, required String password}) async {
    try {
      Response response = await dio.post(Strings.updatePasswordUrl,
          data: {"user_id": userId, "password": password});
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static editProfile({required String email, String? name, String? address}) async {
    try {
      Response response = await dio.post(
        Strings.editProfileUrl,
        data: {
          "email": email,
          "name": name, 
          "address": address,
        },
      );
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static sendOTP({String? email, String? phoneNumber}) async {
    try {
      Response response = await dio.get(
        Strings.resetPasswordUrl,
        queryParameters: {
          if(email != null)
          "email": email,
          if(phoneNumber != null && email == null)
          "phone": phoneNumber,
        },
      );
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static verifyOTP({required String userId, required String otp}) async {
    try {
      Response response = await dio.post(
        Strings.verifyOTPUrl,
        queryParameters: {
          "user_id": userId,
          "otp": otp,
        },
      );
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getExams(int classId) async {
    String url = "${Strings.examsUrl}/$classId";
    print(url);
    try {
      Response response = await dio.get(url);

      print("ABa respnse aunaxa----------------------------------------------");
      print(json.encode(response.data));

      return SuccessResponse(
        data: examModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSubjects() async {
    try {
      Response response = await dio.get(Strings.subjectsUrl);
      return SuccessResponse(
        data: subjectModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSubjectsWithId({
    required String classId,
    required String sectionId,
    required String examId,
  }) async {
    try {
      var data = examId == ""
          ? {
              "class_id": classId,
              "section_id": sectionId,
            }
          : {
              "class_id": classId,
              "section_id": sectionId,
              "exam_id": examId,
            };

      Response response = await dio.post(Strings.techerSubjectUrl, data: data);
      return SuccessResponse(
        data: teachersubjectModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getClasses({
    bool isAll = false,
  }) async {
    try {
      Response response =
          await dio.get(isAll ? "/class-list" : Strings.classesUrl);
      return SuccessResponse(
        data: classModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getNotifications() async {
    try {
      Response response = await dio.get(Strings.getNotifications);
      return SuccessResponse(
        data: response.data["data"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getCASClasses() async {
    try {
      Response response =
          await dio.get(Strings.classCASUrl, queryParameters: {"type": "cas"});
      print(response.data);
      return SuccessResponse(
        data: classModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSections(String classId) async {
    try {
      Response response = await dio.get("${Strings.sectionsUrl}/$classId");
      print(response.data);
      return SuccessResponse(
        data: sectionModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getMonths() async {
    try {
      Response response = await dio.get(Strings.monthUrl);
      return SuccessResponse(
        data: monthModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getAttendanceReport(String type,
      String classId, String sectionId, String monthId) async {
    try {
      Map body = {
        "type": type,
        'class_id': classId,
        'section_id': sectionId,
        'month_id': monthId,
      };
      Response response =
          await dio.post('teacher/student-attendance/report', data: body);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getTeacherAttendanceReport({String? type}) async {
    try {
      Response response = await dio.get('teacher/attendance/report?type=${type ?? ""}');
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getCasEvaluation(String classId, String sectionId, String subjectId, String date) async {
    try {
      Map<String, dynamic> body = {
        'class_id': classId,
        'section_id': sectionId,
        'subject_id': subjectId,
        'date': date,
      };
      Response response = await dio.get('teacher/exam/cas-evaluation/create', data: body);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> storeCasEvaluation({
    required Map<String, dynamic> casData,
  }) async {
    try {
      Response response = await dio.post("teacher/exam/cas-evaluation/store", data: casData);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getMonthlyCasReport(String classId, String sectionId, String subjectId, String monthId) async {
    try {
      Map<String, dynamic> body = {
        'class_id': classId,
        'section_id': sectionId,
        'subject_id': subjectId,
        'month_id': monthId,
      };
      Response response = await dio.get('teacher/exam/cas-evaluation/report', data: body);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getQRAttendanceReport(
    String classId,
    String sectionId,
    String monthId,
    List<int> attendanceTypes,
  ) async {
    try {
      Map body = {
        'type_ids': attendanceTypes,
        'class_id': classId,
        'section_id': sectionId,
        'month_id': monthId,
      };
      Response response = await dio.post('/attendance/qr-report', data: body);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getMarksLedger(String searchType, String classId,
      String sectionId, String examId) async {
    try {
      Map body = {
        'class_id': classId,
        'section_id': sectionId,
        'exam_id': examId,
        "search_type": searchType,
      };
      Response response = await dio.post(Strings.marksLedgerUrl, data: body);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  // assign Marks

  static Future<BaseResponse> getMarks(
      {required String classId,
      required String sectionId,
      required String examId,
      required String subjectId}) async {
    try {
      Map body = {
        'class_id': classId,
        'section_id': sectionId,
        'exam_id': examId,
        'subject_id': subjectId,
      };

      Response response = await dio.post(Strings.assignMarksUrl, data: body);
      log(response.toString());
      return SuccessResponse(
        data: assignMarksModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> setMarks(
      {required String examSetupDetailId,
      required List studentIds,
      required List theoryMarks,
      required List practicalMarks}) async {
    try {
      Map body = {
        "exam_setup_detail_id": examSetupDetailId,
        "student_ids": studentIds,
        "th_marks": theoryMarks,
        "pr_marks": practicalMarks,
      };

      Response response = await dio.post(Strings.storeMarksUrl, data: body);
      return SuccessResponse(
        data: response.data["alert_msg"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getAttendanceDetails(
    String classId,
    String sectionId,
    String date,
    String type,
  ) async {
    try {
      Map body = {
        'class_id': classId,
        'section_id': sectionId,
        "attendance_date": date,
        "type": type,
      };
      Response response =
          await dio.post('teacher/student-attendance', data: body);
      return SuccessResponse(
        data: response.data["data"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  Future<BaseResponse> getNoticeBoardTeaceher() async {
    try {
      Response response = await dio.post('/notice-board');
      return SuccessResponse(
        data: response.data["data"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  // ECA

  static Future<BaseResponse> getEcaMarks(
      {required String classId,
      required String sectionId,
      required String examId}) async {
    try {
      final body = {
        'class_id': classId,
        'section_id': sectionId,
        'exam_id': examId,
      };

      final response = await dio.post(
        Strings.assingEcaMarksUrl,
        data: body,
      );
      print(response.data);
      return SuccessResponse(
        data: response.data["data"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> setEcaMarks({
    required String examSetupDetailId,
    required Map ecaMarks,
    required Map totalAttendance,
  }) async {
    try {
      Map body = {
        "exam_setup_id": examSetupDetailId,
        "eca_marks": ecaMarks,
        "total_attendance": totalAttendance,
      };

      Response response = await dio.post(Strings.storeMarksUrl, data: body);

      return SuccessResponse(
        data: response.data["alert_msg"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  // CAS
  // ECA

  static Future<BaseResponse> getCasMarks({
    required String classId,
    required String sectionId,
    required String examId,
    required String subjectId,
  }) async {
    try {
      final body = {
        'class_id': classId,
        'section_id': sectionId,
        'exam_id': examId,
        'subject_id': subjectId,
      };

      final response = await dio.post(
        Strings.assignCasMarksUrl,
        data: body,
      );
      return SuccessResponse(
        data: assignCasMarksModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> setCasMarks({
    required String examSetupDetailId,
    required Map ecaMarks,
  }) async {
    try {
      Map body = {
        "exam_setup_detail_id": examSetupDetailId,
        "cas_practical_marks": ecaMarks,
      };
      log(json.encode(body));

      Response response = await dio.post(Strings.storeMarksUrl, data: body);

      return SuccessResponse(
        data: response.data["alert_msg"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getCasTypes() async {
    try {
      final response = await dio.get(
        Strings.casTypes,
      );
      return SuccessResponse(
        data: response.data["data"]["types"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getExamTypes() async {
    try {
      final response = await dio.get(
        Strings.examTypes,
      );
      return SuccessResponse(
        data: response.data["data"]["types"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getExamsList(
      {required String type, required String classId}) async {
    try {
      var body = {
        "type": type,
        "class_id": classId,
      };
      final response = await dio.post(
        Strings.getExamsList,
        data: body,
      );
      return SuccessResponse(
        data: response.data["data"]["exams"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> fetchUATMarks({
    required String type,
    required String classId,
    required String sectionId,
    required String examId,
    required String subjectId,
    required String examIdForUT,
    required String casType,
  }) async {
    try {
      var body = {
        'type': type,
        'cas_type': casType,
        'class_id': classId,
        'section_id': sectionId,
        'exam_id': examId,
        'subject_id': subjectId,
        'exam_id_for_ut': examIdForUT,
      };
      final response = await dio.post(
        Strings.fetchUtMarks,
        data: body,
      );
      return SuccessResponse(
        data: response.data["data"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  // set attendance
  static Future<BaseResponse> setAttendance({
    required String type,
    required String date,
    required List studentClassIds,
    required List isPresent,
    required bool isHoliday,
  }) async {
    try {
      Map body = {
        "type": type,
        "attendance_date": date,
        "is_holiday": isHoliday,
        "student_class_id": studentClassIds,
        "is_present": isPresent
      };

      Response response =
          await dio.post(Strings.storeStudentAttendanceUrl, data: body);

      return SuccessResponse(
        data: response.data["message"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  //add homework
  static Future<BaseResponse> addHomework({
    required String classId,
    required String sectionId,
    required String subjectId,
    required String description,
    required String homeworkDate,
    required String homeworkSubmissionDate,
    required List<File> images,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "class_id": classId,
        "section_id": sectionId,
        "subject_id": subjectId,
        "description": description,
        "homework_date": homeworkDate,
        "homework_submission_date": homeworkSubmissionDate,
      });
      for (File item in images) {
        formData.files.addAll([
          MapEntry("image_field[]", await MultipartFile.fromFile(item.path)),
        ]);
      }

      Response response = await dio.post(Strings.addHomework, data: formData);

      return SuccessResponse(
        data: response.data["message"],
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  //get homework

  static Future<BaseResponse> getHomeworkByDate({
    required String startDate,
  }) async {
    try {
      final body = {
        'start_date': startDate,
      };

      final response = await dio.get(
        Strings.addHomework,
        queryParameters: body,
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getHomeworkDetails(int id) async {
    try {
      final response = await dio.get(
        "${Strings.homeworkDetails}/$id",
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSudentHomework(
      int homeworkId, int studentId) async {
    try {
      final response = await dio.get(Strings.getStudentHomeworkDetails,
          queryParameters: {"homework_id": homeworkId, "user_id": studentId});
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> evaluateHomework(
      int id, List completed, String evaluationDate) async {
    try {
      Map<String, dynamic> isCompleted = {};
      for (int i = 0; i < completed.length; i++) {
        isCompleted["${completed[i]["user_id"]}"] =
            completed[i]["is_completed"] == true
                ? 1
                : completed[i]["is_completed"] == false
                    ? 0
                    : null;
      }
      var validateData = {
        "is_completed": isCompleted,
        "evaluation_date": evaluationDate
      };

      final response = await dio.post(
        "${Strings.homeworkEvaluation}/$id",
        data: validateData,
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> deleteHomework({required int homeWorkId}) async {
    try {
      final response = await dio.delete(
        "${Strings.addHomework}/$homeWorkId",
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> deleteHomeworkFile(
      {required int homeworkFileId}) async {
    try {
      final response =
          await dio.get(Strings.deleteHomeworkFile, queryParameters: {
        "homework_file_id": homeworkFileId,
      });
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> addHomeworkComment(
      {required int homeworkFileId, required String comment}) async {
    try {
      final response = await dio.post(
        Strings.addhomeworkComment,
        data: {
          "homework_list_id": homeworkFileId,
          "comment": comment,
        },
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getNotices() async {
    try {
      final response = await dio.get(Strings.getNotices);
      return SuccessResponse<Map<String, dynamic>>(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getNoticesDetails(int id) async {
    try {
      final response = await dio.get("${Strings.getNotices}/$id");
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> pushNotificationUsingFcm({
    required String title,
    required String description,
    String? imageUrl,
  }) async {
    try {
      var data = {
        "to":
            "/topics/${LocalStorageMethods.getSchoolDetails()["domain_name"] + "-" + 'teacher'}",
        "data": {
          "title": title,
          "description": description,
          "imageUrl": imageUrl ?? "",
          "type": "AllStar",
        },
        "content_available": true,
        "android": {"priority": "high"}
      };
      final response = await Dio().post(
        "https://fcm.googleapis.com/fcm/send",
        options: Options(
          headers: _authfcmHeaders,
        ),
        data: data,
      );
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Map<String, String> get _authfcmHeaders => {
        "Content-type": "application/json",
        "Accept": 'application/json',
        "Authorization":
            "key=AAAAXFOKoyQ:APA91bHpgiRhLh0AqpHfzaGo2r35CXRX-MsyUQvNM_u0WIK-M6Dvph5nzGkIOZP-pPd3LOFxLfDDh_Jp-CG60lWUfQ_7mYlYPwlM4O_PFmwwneSsPEEUp4NsVLSwS_Y7VBeNG8NWdgHp"
      };

  static Future<BaseResponse> getAttendanceType() async {
    try {
      Response response = await dio.get("/teacher/student-attendance/type");
      return SuccessResponse(
        data: attendanceTypeModelFromJson(response.data["data"]),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> uploadProfileImageTeacher(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "image_field": await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });
      Response response = await dio.post(
        "/teacher/profile/store",
        data: formData,
      );
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }
}
