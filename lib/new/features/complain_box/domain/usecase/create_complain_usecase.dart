import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class CreateComplainsUsecase
    extends Usecase<ComplainEntity, CreateComplainUsecaseParams> {
  final IComplainBoxRepository repository;

  CreateComplainsUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, ComplainEntity>> call(
      CreateComplainUsecaseParams params) async {
    return await repository.createComplain(
        roleId: params.roleId,
        title: params.title,
        description: params.description,
        complainToIds: params.complainToIds);
  }
}

class CreateComplainUsecaseParams {
  final int roleId;
  final String title;
  final String description;
  final List<int> complainToIds;

  CreateComplainUsecaseParams({
    required this.roleId,
    required this.title,
    required this.description,
    required this.complainToIds,
  });
}
