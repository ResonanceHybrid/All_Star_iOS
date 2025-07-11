import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_entity.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/repository/exam_routine_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:all_star_learning/Utils/local_storage.dart';

class GetExamListUsecase extends Usecase<List<ExamEntity>, int?> {
  final IExamRoutineRepository repository;

  GetExamListUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, List<ExamEntity>>> call(int? params) async {
    return await repository.getExamList(
      classId:
          params ?? LocalStorageMethods.getUserDetails()["data"]["class_id"],
    );
  }
}
