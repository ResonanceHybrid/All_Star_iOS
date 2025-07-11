import 'dart:io';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/interceptor.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:dio/dio.dart';

class StudentApiMethods {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ))
    ..interceptors.add(NetworkInterceptor());

  static Future<BaseResponse> getExamResultYearList(
      {required int academicYearId}) async {
    try {
      Response response = await dio.get(Strings.studentExamYearList,
          queryParameters: {'academic_year_id': academicYearId});
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getYearList() async {
    try {
      Response response = await dio.get("year-list");
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getExamResultDetails(int id) async {
    try {
      Response response = await dio.get("${Strings.studentExamDetails}/$id}");
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getContentTypes() async {
    try {
      Response response = await dio.get(Strings.studentContentTypes);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getContentDetails(int id) async {
    try {
      Response response = await dio
          .get(Strings.studentContentData, queryParameters: {"type_id": id});
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> studentFeesData() async {
    try {
      Response response = await dio.get(Strings.studentFees);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> studentDueDetails() async {
    try {
      Response response = await dio.get(Strings.studentDueDetails);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> schoolDetail() async {
    try {
      Response response = await dio.get("school/details");
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> studentFeesDetails(int id, String type) async {
    try {
      Response response =
          await dio.get("${Strings.studentFeesDetails}?type=$type&id=$id");
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSubjects() async {
    try {
      Response response = await dio.get(Strings.studentSubjects);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getTeachers() async {
    try {
      Response response = await dio.get(Strings.studentTeachers);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getAllHomeWork() async {
    try {
      Response response = await dio.get(Strings.studentHomework);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getSubmittedHomework(int homeworkId) async {
    try {
      Response response =
          await dio.get("${Strings.studentHomework}/$homeworkId");
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> deleteSubmittedHomework(int homeworkId) async {
    try {
      Response response = await dio.get(Strings.studentHomeworkDelete,
          queryParameters: {"homework_file_id": homeworkId});
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getProfileData() async {
    try {
      Response response = await dio.get(Strings.studentProfileData);
      return SuccessResponse(
        data: response.data,
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> uploadFCMToken({
    required String userId,
    required String token,
  }) async {
    try {
      Response response = await dio.post(Strings.uploadFCMToken, data: {
        "user_id": userId,
        "device_token": token,
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

  static Future<BaseResponse> uploadProfileImage(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "image_field": await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });
      Response response = await dio.post(
        Strings.uploadProfile,
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

  static Future<BaseResponse> uploadHomework(
      List<File> imageList, int homeworkId) async {
    try {
      print("Uploading Homework");
      print(imageList);
      List uploadList = [];
      for (var file in imageList) {
        var multipartFile = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last);
        uploadList.add(multipartFile);
      }

      FormData formData = FormData.fromMap(
          {"image_field[]": uploadList, "homework_id": homeworkId});
      Response response = await dio.post(
        Strings.studentHomework,
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

  //get events
  static Future<BaseResponse> getEvents({
    int? typeID,
  }) async {
    try {
      Response response = await dio.get(
        Strings.getEvents,
        queryParameters: {
          "type": typeID,
        },
      );
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getAttendance({
    required int typeID,
  }) async {
    try {
      Response response =
          await dio.get(Strings.getAttendance, queryParameters: {
        "type": typeID,
      });
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }

  static Future<BaseResponse> getBioAttendance() async {
    try {
      Response response = await dio.get(Strings.getBioAttendance);
      return SuccessResponse(data: response.data);
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.message,
      );
    }
  }
}
