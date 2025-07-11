import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateComplainsUsecase
    extends Usecase<ComplainEntity, UpdateComplainUsecaseParams> {
  final IComplainBoxRepository repository;

  UpdateComplainsUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> call(
      UpdateComplainUsecaseParams params) async {
    return await repository.updateComplain(
        complainId: params.complainId,
        roleId: params.roleId,
        title: params.title,
        description: params.description,
        complainToIds: params.complainToIds);
  }
}

class UpdateComplainUsecaseParams {
  final int complainId;
  final int? roleId;
  final String? title;
  final String? description;
  final List<int>? complainToIds;

  UpdateComplainUsecaseParams({
    required this.complainId,
    this.roleId,
    this.title,
    this.description,
    this.complainToIds,
  });
}
