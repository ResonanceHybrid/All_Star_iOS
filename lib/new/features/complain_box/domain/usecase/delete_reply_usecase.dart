import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/replies_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteReplyUsecase extends Usecase<RepliesEntity, int> {
  final IComplainBoxRepository repository;

  DeleteReplyUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, RepliesEntity>> call(int params) async {
    return await repository.deleteReply(
      complainId: params,
    );
  }
}
