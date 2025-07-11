import 'dart:developer';

import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/qr/data/models/qr_attendance_type_model.dart';
import 'package:all_star_learning/new/features/qr/data/models/scan_studnet_response_model.dart';
import 'package:dartz/dartz.dart';

class QrRemoteDataSource {
  final DioHttpService api;

  QrRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, ScanStudentResponseModel>> scanQR({
    required String userID,
    required String type,
  }) async {
    try {
      final response = await api.handlePostRequest(path: "/handle-scan", data: {
        "user_id": userID,
        "type": type,
      });
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return Left(AppErrorHandler(message: "No data found"));
        }
        return Right(ScanStudentResponseModel.fromMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, List<QRAttendanceTypeModel>>> getScanType({
    bool report = true,
    bool student = false,
  }) async {
    log("report: $report, student: $student");
    try {
      final response = await api.handleGetRequest(
        path: report
            ? "/scan-types?report=1"
            : student
                ? "/teacher/student-attendance/type"
                : "/scan-types",
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return Left(AppErrorHandler(message: "No data found"));
        }
        if (student) {
          return Right(QRAttendanceTypeModel.fromListMap(
            data: response.data['data'],
            student: true,
          ));
        }
        if (response.data['data']['types'] == null) {
          return Left(AppErrorHandler(message: "No data found"));
        }
        return Right(QRAttendanceTypeModel.fromListMap(
            data: response.data['data']['types']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }

  Future<Either<AppErrorHandler, String>> getStudentQrReport({
    required int monthId,
  }) async {
    try {
      final response = await api
          .handleGetRequest(path: "student/qr-report", queryParameters: {
        "month_id": monthId,
      });
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }
}
