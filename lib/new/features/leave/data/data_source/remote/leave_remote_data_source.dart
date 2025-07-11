import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/leave/data/models/leave_model.dart';
import 'package:dartz/dartz.dart';

class LeaveRemoteDataSource {
  final DioHttpService api;

  LeaveRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, List<LeaveModel>>> getListOfLeaves() async {
    try {
      final response = await api.handleGetRequest(
        path: "/leave-appplication",
      );
      if (response.statusCode == 200) {
        return Right(LeaveModel.fromListMap(response.data['data']));
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

  Future<Either<AppErrorHandler, List<LeaveModel>>> deleteLeave({
    required int leaveId,
  }) async {
    try {
      final response = await api.handleDeleteRequest(
        path: "/leave-appplication/$leaveId",
      );
      if (response.statusCode == 200) {
        return Right(LeaveModel.fromListMap(response.data['data']));
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

  Future<Either<AppErrorHandler, LeaveModel>> createLeave({
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      final response = await api.handlePostRequest(
        path: "/leave-appplication",
        data: {
          "subject": subject,
          "reason": reason,
          "date_from": fromDate,
          "date_to": toDate,
        },
      );
      if (response.statusCode == 200) {
        return Right(LeaveModel.fromMap(response.data['data']));
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

  Future<Either<AppErrorHandler, LeaveModel>> updateLeave({
    required int leaveId,
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      final response = await api.handlePutRequest(
        path: "/leave-appplication/$leaveId",
        data: {
          "subject": subject,
          "reason": reason,
          "date_from": fromDate,
          "date_to": toDate,
        },
      );
      if (response.statusCode == 200) {
        return Right(LeaveModel.fromMap(response.data['data']));
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
