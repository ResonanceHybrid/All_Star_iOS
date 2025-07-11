import 'package:all_star_learning/Resources/interceptor.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHttpService {
  Future<Dio> getDioClient() async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
    dio.interceptors.add(
      NetworkInterceptor(),
    );
    return dio;
  }

  Future<Response> handleGetRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Dio dio = await getDioClient();
    try {
      return await dio.get(
        path,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse ||
          e.type == DioExceptionType.cancel ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        CustomMethods()
            .showSnackBar(getx.Get.context!, e.message.toString(), Colors.red);
        return Response(
          statusMessage: e.message,
          data: e.response?.data,
          requestOptions: RequestOptions(path: path),
          statusCode: e.response?.statusCode,
        );
      }
      return Response(
        statusMessage: e.message,
        data: e.response?.data,
        requestOptions: RequestOptions(path: path),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> handlePostRequest({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Dio dio = await getDioClient();
    try {
      return await dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse ||
          e.type == DioExceptionType.cancel ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        CustomMethods()
            .showSnackBar(getx.Get.context!, e.message.toString(), Colors.red);
        return Response(
          statusMessage: e.message,
          data: e.response?.data,
          requestOptions: RequestOptions(path: path),
          statusCode: e.response?.statusCode,
        );
      }
      return Response(
        statusMessage: e.message,
        data: e.response?.data,
        requestOptions: RequestOptions(path: path),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> handlePutRequest({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Dio dio = await getDioClient();
    try {
      return await dio.put(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse ||
          e.type == DioExceptionType.cancel ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        CustomMethods()
            .showSnackBar(getx.Get.context!, e.message.toString(), Colors.red);
        return Response(
          statusMessage: e.message,
          data: e.response?.data,
          requestOptions: RequestOptions(path: path),
          statusCode: e.response?.statusCode,
        );
      }
      return Response(
        statusMessage: e.message,
        data: e.response?.data,
        requestOptions: RequestOptions(path: path),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> handleDeleteRequest({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Dio dio = await getDioClient();
    try {
      return await dio.delete(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse ||
          e.type == DioExceptionType.cancel ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        CustomMethods()
            .showSnackBar(getx.Get.context!, e.message.toString(), Colors.red);
        return Response(
          statusMessage: e.message,
          data: e.response?.data,
          requestOptions: RequestOptions(path: path),
          statusCode: e.response?.statusCode,
        );
      }
      return Response(
        statusMessage: e.message,
        data: e.response?.data,
        requestOptions: RequestOptions(path: path),
        statusCode: e.response?.statusCode,
      );
    }
  }
}
