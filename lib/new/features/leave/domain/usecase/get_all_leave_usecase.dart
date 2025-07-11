import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:all_star_learning/new/features/leave/domain/repository/leave_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllLeavesUsecase extends Usecase<List<LeaveEntity>, void> {
  final ILeaveRepository repository;

  GetAllLeavesUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<LeaveEntity>>> call(void params) async {
    return await repository.getListOfLeaves();
  }
}
