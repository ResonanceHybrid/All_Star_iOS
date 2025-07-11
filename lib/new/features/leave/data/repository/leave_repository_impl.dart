import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/leave/data/models/leave_model.dart';


import 'package:dartz/dartz.dart';

import '../data_source/remote/leave_remote_data_source.dart';
import '../../domain/repository/leave_repository.dart';

class LeaveRepositoryImpl implements ILeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;

  LeaveRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<LeaveModel>>> getListOfLeaves() async {
    return await remoteDataSource.getListOfLeaves();
  }

  @override
  Future<Either<AppErrorHandler, List<LeaveModel>>> deleteLeave(
      {required int leaveId}) async {
    return await remoteDataSource.deleteLeave(leaveId: leaveId);
  }

  @override
  Future<Either<AppErrorHandler, LeaveModel>> createLeave({
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    return await remoteDataSource.createLeave(
      subject: subject,
      reason: reason,
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  @override
  Future<Either<AppErrorHandler, LeaveModel>> updateLeave({
    required int leaveId,
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    return await remoteDataSource.updateLeave(
      leaveId: leaveId,
      subject: subject,
      reason: reason,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
