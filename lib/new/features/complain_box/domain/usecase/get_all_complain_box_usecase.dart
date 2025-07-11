import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllComplainsUsecase extends Usecase<List<ComplainEntity>, void> {
  final IComplainBoxRepository repository;

  GetAllComplainsUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, List<ComplainEntity>>> call(
      void params) async {
    return await repository.getComplains();
  }
}
