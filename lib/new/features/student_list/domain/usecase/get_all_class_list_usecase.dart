import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/class_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/repository/student_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetClassListUsecase extends Usecase<List<ClassEntity>, bool?> {
  final IStudentListRepository repository;

  GetClassListUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<ClassEntity>>> call(bool? params) async {
    return await repository.getClassList(
      all: params ?? false,
    );
  }
}
