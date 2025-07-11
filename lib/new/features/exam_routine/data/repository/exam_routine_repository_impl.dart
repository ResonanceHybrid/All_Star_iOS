import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/exam_routine/data/models/exam_model.dart';
import 'package:all_star_learning/new/features/exam_routine/data/models/exam_routine_model.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/exam_routine_remote_data_source.dart';
import '../../domain/repository/exam_routine_repository.dart';

class ExamRoutineRepositoryImpl implements IExamRoutineRepository {
  final ExamRoutineRemoteDataSource remoteDataSource;

  ExamRoutineRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, ExamRoutineModel>> getExamRoutine({
    required int examId,
    required int classId,
  }) async {
    return await remoteDataSource.getExamRoutine(
      examId: examId,
      classId: classId,
    );
  }

  @override
  Future<Either<AppErrorHandler, List<ExamModel>>> getExamList(
      {required int classId}) async {
    return await remoteDataSource.getExamList(classId: classId);
  }
}
