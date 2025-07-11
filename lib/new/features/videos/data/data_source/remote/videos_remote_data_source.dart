import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/videos/data/models/video_model.dart';
import 'package:dartz/dartz.dart';

class VideosRemoteDataSource {
  final DioHttpService api;

  VideosRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, List<VideoModel>>> getAllModels() async {
    try {
      final response = await api.handleGetRequest(
        path: "/video-list",
      );
      if (response.statusCode == 200) {
        return Right(VideoModel.fromListMap(response.data['data']));
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
