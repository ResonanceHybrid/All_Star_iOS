import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/school_list_model.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class InitialApi {
  static Dio dio = Dio(BaseOptions(baseUrl: Strings.baseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  }))
    ..interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

  static Future<BaseResponse> getSchoolList({String? schoolName, int? page}) async {
    try {
      final response = await dio.get(Strings.schoolList, queryParameters: {
        "name": schoolName ?? "demo",
        "page": page,
      });
      return SuccessResponse(
        data: schoolListModelFromJson(response.data),
      );
    } on DioException catch (e) {
      return ErrorResponse(
        message: e.response?.data["message"] ?? Strings.somethingWentWrong,
      );
    }
  }
}
