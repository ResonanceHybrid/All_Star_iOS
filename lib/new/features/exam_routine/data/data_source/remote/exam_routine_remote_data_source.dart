import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/exam_routine/data/models/exam_model.dart';
import 'package:all_star_learning/new/features/exam_routine/data/models/exam_routine_model.dart';
import 'package:dartz/dartz.dart';

class ExamRoutineRemoteDataSource {
  final DioHttpService api;

  ExamRoutineRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, ExamRoutineModel>> getExamRoutine({
    required int examId,
    required int classId,
  }) async {
    try {
      final response =
          await api.handleGetRequest(path: "/exam-routine", queryParameters: {
        "exam_id": examId,
        "class_id": classId,
      });
      if (response.statusCode == 200) {
        return Right(ExamRoutineModel.fromMap(response.data['data']));
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

  Future<Either<AppErrorHandler, List<ExamModel>>> getExamList({
    required int classId,
  }) async {
    try {
      final response = await api.handleGetRequest(
        path: "exam-list/$classId",
      );
      if (response.statusCode == 200) {
        return Right(ExamModel.fromListMap(response.data['data']));
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
