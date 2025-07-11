import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class GetRoleUserListUsecase extends Usecase<List<RoleUserEntity>, int> {
  final IComplainBoxRepository repository;

  GetRoleUserListUsecase({
    required this.repository,
  });
  @override
  Future<Either<AppErrorHandler, List<RoleUserEntity>>> call(int params) async {
    return await repository.getRoleUsers(
      roleId: params,
    );
  }
}
