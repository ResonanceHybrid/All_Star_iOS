import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:all_star_learning/new/features/leave/domain/repository/leave_repository.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/create_leave_usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateLeaveUsecase extends Usecase<LeaveEntity, LeaveParams> {
  final ILeaveRepository repository;

  UpdateLeaveUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, LeaveEntity>> call(LeaveParams params) async {
    return await repository.updateLeave(
      leaveId: params.leaveId!,
      subject: params.subject,
      reason: params.reason,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}
