import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:all_star_learning/new/features/leave/domain/repository/leave_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteLeaveUsecase extends Usecase<List<LeaveEntity>, int> {
  final ILeaveRepository repository;

  DeleteLeaveUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<LeaveEntity>>> call(int params) async {
    return await repository.deleteLeave(leaveId: params);
  }
}
