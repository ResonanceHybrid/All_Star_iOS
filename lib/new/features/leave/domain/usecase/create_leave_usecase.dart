import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:all_star_learning/new/features/leave/domain/repository/leave_repository.dart';
import 'package:dartz/dartz.dart';

class CreateLeaveUsecase extends Usecase<LeaveEntity, LeaveParams> {
  final ILeaveRepository repository;

  CreateLeaveUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, LeaveEntity>> call(
      LeaveParams params) async {
    return await repository.createLeave(
      subject: params.subject,
      reason: params.reason,
      fromDate: params.fromDate,
      toDate: params.toDate,
    );
  }
}

class LeaveParams {
  final int? leaveId;
  final String subject;
  final String reason;
  final String fromDate;
  final String toDate;

  LeaveParams({
    this.leaveId,
    required this.subject,
    required this.reason,
    required this.fromDate,
    required this.toDate,
  });
}
