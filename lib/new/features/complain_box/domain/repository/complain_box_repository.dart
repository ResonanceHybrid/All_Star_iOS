import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/replies_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IComplainBoxRepository {
  Future<Either<AppErrorHandler, List<ComplainEntity>>> getComplains();
  Future<Either<AppErrorHandler, ComplainEntity>> createComplain({
    required int roleId,
    required String title,
    required String description,
    required List<int> complainToIds,
  });
  Future<Either<AppErrorHandler, ComplainEntity>> updateComplain({
    required int complainId,
    required int? roleId,
    required String? title,
    required String? description,
    required List<int>? complainToIds,
  });
  Future<Either<AppErrorHandler, ComplainEntity>> getSingleComplaint({
    required int complainId,
  });

  Future<Either<AppErrorHandler, List<RoleUserEntity>>> getRoleUsers({
    required int roleId,
  });

  Future<Either<AppErrorHandler, List<RoleUserEntity>>> getRoleList();

  Future<Either<AppErrorHandler, bool>> deleteComplain({
    required int complainId,
  });

  Future<Either<AppErrorHandler, RepliesEntity>> createReply({
    required int complainId,
    required String description,
  });

  Future<Either<AppErrorHandler, RepliesEntity>> deleteReply({
    required int complainId,
  });
}
