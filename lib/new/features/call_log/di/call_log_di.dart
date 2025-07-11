import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/call_log/data/data_source/remote/call_log_remote_data_source.dart';
import 'package:all_star_learning/new/features/call_log/data/repository/call_log_repository_impl.dart';
import 'package:all_star_learning/new/features/call_log/domain/repository/call_log_repository.dart';
import 'package:all_star_learning/new/features/call_log/domain/usecase/get_all_call_log_usecase.dart';
import 'package:all_star_learning/new/features/call_log/presentation/cubit/call_log_cubit.dart';

class CallLogDI {
  register() {
    locator.registerFactory(
      () => CallLogRemoteDataSource(
        api: locator(),
      ),
    );
    locator.registerFactory<ICallLogRepository>(
      () => CallLogRepositoryImpl(
        remoteDataSource: locator(),
      ),
    );

    locator.registerFactory(
      () => GetAllCallLogsUsecase(
        repository: locator(),
      ),
    );

    locator.registerLazySingleton(() => CallLogCubit(
          getAllCallLogsUsecase: locator(),
        ));
  }
}
