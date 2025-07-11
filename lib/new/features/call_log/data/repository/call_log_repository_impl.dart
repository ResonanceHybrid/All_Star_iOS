import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/call_log/data/models/call_log_model.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/call_log_remote_data_source.dart';
import '../../domain/repository/call_log_repository.dart';

class CallLogRepositoryImpl implements ICallLogRepository {
  final CallLogRemoteDataSource remoteDataSource;

  CallLogRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<CallLogModel>>> getAllCallLogs() async {
    return await remoteDataSource.getAllCallLogs();
  }
}
