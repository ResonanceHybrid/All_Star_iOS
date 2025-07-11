import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class GetRoleListUsecase extends Usecase<List<RoleUserEntity>, void> {
  final IComplainBoxRepository repository;

  GetRoleListUsecase({
    required this.repository,
  });
  @override
  Future<Either<AppErrorHandler, List<RoleUserEntity>>> call(
      void params) async {
    return await repository.getRoleList();
  }
}
