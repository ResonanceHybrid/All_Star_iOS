import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/section_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/repository/student_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetClassSectionListUsecase extends Usecase<List<SectionEntity>, int> {
  final IStudentListRepository repository;

  GetClassSectionListUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<SectionEntity>>> call(int params) async {
    return await repository.getSectionList(
      classId: params,
    );
  }
}
