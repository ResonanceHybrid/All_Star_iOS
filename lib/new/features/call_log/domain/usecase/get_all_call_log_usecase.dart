import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/call_log/domain/entities/call_log_entity.dart';
import 'package:all_star_learning/new/features/call_log/domain/repository/call_log_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCallLogsUsecase extends Usecase<List<CallLogEntity>, void> {
  final ICallLogRepository repository;

  GetAllCallLogsUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, List<CallLogEntity>>> call(void params) async {
    return await repository.getAllCallLogs();
  }
}
