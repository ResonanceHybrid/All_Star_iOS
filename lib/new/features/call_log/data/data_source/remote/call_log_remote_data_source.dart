import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/call_log/data/models/call_log_model.dart';
import 'package:dartz/dartz.dart';

class CallLogRemoteDataSource {
  final DioHttpService api;

  CallLogRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, List<CallLogModel>>> getAllCallLogs() async {
    try {
      final response = await api.handleGetRequest(
        path: "/call-records",
      );
      if (response.statusCode == 200) {
        return Right(CallLogModel.fromListMap(response.data['data']));
      } else {
        if (response.data['message'] == null) {
          return Left(AppErrorHandler(message: "Something went wrong"));
        }
        return Left(AppErrorHandler(message: response.data['message']));
      }
    } catch (e) {
      return Left(AppErrorHandler(message: e.toString()));
    }
  }
}
