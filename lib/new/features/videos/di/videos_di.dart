import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/videos/data/data_source/remote/videos_remote_data_source.dart';
import 'package:all_star_learning/new/features/videos/data/repository/videos_repository_impl.dart';
import 'package:all_star_learning/new/features/videos/domain/repository/videos_repository.dart';
import 'package:all_star_learning/new/features/videos/domain/usecase/get_all_videos_usecase.dart';
import 'package:all_star_learning/new/features/videos/presentation/cubit/videos_cubit.dart';

class VideoDI {
  register() {
    locator.registerFactory(
      () => VideosRemoteDataSource(
        api: locator(),
      ),
    );
    locator.registerFactory<IVideosRepository>(
      () => VideosRepositoryImpl(
        remoteDataSource: locator(),
      ),
    );

    locator.registerFactory(
      () => GetAllVideosUsecase(
        repository: locator(),
      ),
    );

    locator.registerLazySingleton(() => VideosCubit(
          getAllVideosUsecase: locator(),
        ));
  }
}
