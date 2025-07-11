import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/complain_box/data/data_source/remote/complain_box_remote_data_source.dart';
import 'package:all_star_learning/new/features/complain_box/data/repository/complain_box_repository_impl.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/create_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/create_reply_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/delete_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/delete_reply_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_all_complain_box_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_role_list_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_role_user_list_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_single_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/update_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/presentation/cubit/complain_box_cubit.dart';

class ComplainBoxDI {
  register() {
    locator.registerFactory(
      () => ComplainBoxRemoteDataSource(
        api: locator(),
      ),
    );
    locator.registerFactory<IComplainBoxRepository>(
      () => ComplainBoxRepositoryImpl(
        remoteDataSource: locator(),
      ),
    );
    locator.registerFactory(
      () => CreateComplainsUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => UpdateComplainsUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => GetAllComplainsUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => GetSingleComplainsUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => GetRoleListUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => GetRoleUserListUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => DeleteComplainUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => CreateReplyUsecase(
        repository: locator(),
      ),
    );
    locator.registerFactory(
      () => DeleteReplyUsecase(
        repository: locator(),
      ),
    );

    locator.registerLazySingleton(() => ComplainBoxCubit(
          createComplainUsecase: locator(),
          updateComplainUsecase: locator(),
          getAllComplainsUsecase: locator(),
          getSingleComplainsUsecase: locator(),
          getRoleListUsecase: locator(),
          getRoleUserListUsecase: locator(),
          deleteComplainUsecase: locator(),
          createReplyUsecase: locator(),
          deleteReplyUsecase: locator(),
        ));
  }
}
