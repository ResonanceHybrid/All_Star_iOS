import 'package:all_star_learning/new/features/videos/domain/entities/video_entity.dart';
import 'package:all_star_learning/new/features/videos/domain/usecase/get_all_videos_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit({
    required this.getAllVideosUsecase,
  }) : super(VideosState.initial());
  final GetAllVideosUsecase getAllVideosUsecase;

  Future<void> getAllVideos({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllVideosUsecase.call(null);
    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(isLoading: false));
      },
      (videos) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          videos: videos,
          selectedVideo: () => null,
          isPlaying: false,
        ));
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void selectVideo(VideoEntity video) {
    emit(
      state.copyWith(
        selectedVideo: () => video,
        isPlaying: true,
      ),
    );
  }
}
