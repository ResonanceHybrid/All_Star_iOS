import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_routine_entity.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/repository/exam_routine_repository.dart';
import 'package:dartz/dartz.dart';

class GetExamRoutineUsecase
    extends Usecase<ExamRoutineEntity, GetExamRoutineParams> {
  final IExamRoutineRepository repository;

  GetExamRoutineUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, ExamRoutineEntity>> call(
      GetExamRoutineParams params) async {
    return await repository.getExamRoutine(
      examId: params.examId,

      classId: params.classId);
  }
}

class GetExamRoutineParams {
  final int examId;
  final int classId;

  GetExamRoutineParams({required this.examId, required this.classId});
}
