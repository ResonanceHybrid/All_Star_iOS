import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/student_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/repository/student_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentListUsecase
    extends Usecase<List<StudentEntity>, StudentListParams> {
  final IStudentListRepository repository;

  GetStudentListUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<StudentEntity>>> call(
      StudentListParams params) async {
    return await repository.getStudents(
      classId: params.classId,
      sectionId: params.sectionId,
    );
  }
}

class StudentListParams {
  final int? classId;
  final int? sectionId;

  StudentListParams({
    this.classId,
    this.sectionId,
  });
}
