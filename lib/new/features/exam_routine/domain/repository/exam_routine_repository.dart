import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_entity.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_routine_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IExamRoutineRepository {
  Future<Either<AppErrorHandler, ExamRoutineEntity>> getExamRoutine({
    required int examId,
    required int classId,
  });
  Future<Either<AppErrorHandler, List<ExamEntity>>> getExamList({
    required int classId,
  });
}
