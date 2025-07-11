import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/leave/data/data_source/remote/leave_remote_data_source.dart';
import 'package:all_star_learning/new/features/leave/data/repository/leave_repository_impl.dart';
import 'package:all_star_learning/new/features/leave/domain/repository/leave_repository.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/create_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/delete_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/get_all_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/update_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/presentation/cubit/leave_cubit.dart';

class LeaveDI {
  void register() {
    locator.registerFactory(() => LeaveRemoteDataSource(api: locator()));
    locator.registerFactory<ILeaveRepository>(() => LeaveRepositoryImpl(
          remoteDataSource: locator(),
        ));
    locator.registerFactory(() => GetAllLeavesUsecase(locator()));
    locator.registerFactory(() => DeleteLeaveUsecase(locator()));
    locator.registerFactory(() => CreateLeaveUsecase(locator()));
    locator.registerFactory(() => UpdateLeaveUsecase(locator()));

    locator.registerLazySingleton(() => LeaveCubit(
          getAllLeavesUsecase: locator(),
          deleteLeaveUsecase: locator(),
          createLeaveUsecase: locator(),
          updateLeaveUsecase: locator(),
        ));
  }
}
