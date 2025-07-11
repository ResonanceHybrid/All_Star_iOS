import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/replies_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class CreateReplyUsecase extends Usecase<RepliesEntity, CreateReplyParams> {
  final IComplainBoxRepository repository;

  CreateReplyUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, RepliesEntity>> call(
      CreateReplyParams params) async {
    return await repository.createReply(
      complainId: params.complainId,
      description: params.description,
    );
  }
}

class CreateReplyParams {
  final int complainId;
  final String description;

  CreateReplyParams({required this.complainId, required this.description});
}
