import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ILeaveRepository {
  Future<Either<AppErrorHandler, List<LeaveEntity>>> getListOfLeaves();
  Future<Either<AppErrorHandler, List<LeaveEntity>>> deleteLeave({
    required int leaveId,
  });
  Future<Either<AppErrorHandler, LeaveEntity>> createLeave({
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  });
  Future<Either<AppErrorHandler, LeaveEntity>> updateLeave({
    required int leaveId,
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  });
}
