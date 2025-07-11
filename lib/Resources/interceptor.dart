import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../utils/local_storage.dart';

class NetworkInterceptor extends QueuedInterceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Map<DioExceptionType, String> errorMessages = {
      DioExceptionType.badCertificate: Strings.sslError,
      DioExceptionType.badResponse: Strings.badResponse,
      DioExceptionType.cancel: Strings.requestCancelled,
      DioExceptionType.connectionError: Strings.connectionError,
      DioExceptionType.connectionTimeout: Strings.connectionTimeout,
      DioExceptionType.receiveTimeout: Strings.responseTimeout,
      DioExceptionType.sendTimeout: Strings.sendTimeout,
      DioExceptionType.unknown: Strings.someThingWentWorng,
    };

    String defaultError = errorMessages[err.type] ?? Strings.somethingWentWrong;

    print("error: ${err.response}");

    DioException error = DioException(
      message: err.response?.data.runtimeType == String
          ? err.response?.data
          : err.response?.data["message"] ?? defaultError,
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
    );

    return super.onError(error, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print(LocalStorageMethods.getSchoolDetails()?["domain_name"] ?? "");
    options.baseUrl =
        'https://${LocalStorageMethods.getSchoolDetails()?["domain_name"] ?? ""}.allstarems.com/api/';

    String accessToken = getaccesstoken();
    print("token: $accessToken");

    options.headers.addAll({
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    return handler.next(options);
  }
}

getaccesstoken() {
  var data = LocalStorageMethods.getUserDetails();
  return data?["token"] ?? "";
}

void performLogout() {
  LocalStorageMethods.removeUserDetails();
  Get.offAllNamed(AppPages.login);
}
