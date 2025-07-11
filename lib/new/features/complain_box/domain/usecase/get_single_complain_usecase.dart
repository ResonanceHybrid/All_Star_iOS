import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleComplainsUsecase extends Usecase<ComplainEntity, int> {
  final IComplainBoxRepository repository;

  GetSingleComplainsUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> call(int params) async {
    return await repository.getSingleComplaint(
      complainId: params,
    );
  }
}
