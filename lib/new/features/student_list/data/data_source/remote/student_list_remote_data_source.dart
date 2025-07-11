import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/student_list/data/models/class_model.dart';
import 'package:all_star_learning/new/features/student_list/data/models/section_model.dart';
import 'package:all_star_learning/new/features/student_list/data/models/student_model.dart';
import 'package:dartz/dartz.dart';

class StudentListRemoteDataSource {
  final DioHttpService api;

  StudentListRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, List<ClassModel>>> getClassList(
      {bool all = false}) async {
    try {
      final response = await api.handleGetRequest(
        path: all ? "class-list" : "/teacher/classes",
      );
      if (response.statusCode == 200) {
        return Right(ClassModel.fromListMap(response.data['data']));
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

  Future<Either<AppErrorHandler, List<SectionModel>>> getSectionList({
    required int classId,
  }) async {
    try {
      final response = await api.handleGetRequest(
        path: "/teacher/get-sections/$classId",
      );
      if (response.statusCode == 200) {
        return Right(SectionModel.fromListMap(response.data['data']));
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

  Future<Either<AppErrorHandler, List<StudentModel>>> getStudents({
    int? classId,
    int? sectionId,
  }) async {
    try {
      final response =
          await api.handleGetRequest(path: "/student-list", queryParameters: {
        "class_id": classId,
        "section_id": sectionId,
      });
      if (response.statusCode == 200) {
        return Right(StudentModel.fromListMap(response.data['data']));
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
