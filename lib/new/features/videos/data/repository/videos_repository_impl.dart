import 'package:all_star_learning/new/core/errors/error_handler.dart';

import 'package:all_star_learning/new/features/videos/domain/entities/video_entity.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/videos_remote_data_source.dart';
import '../../domain/repository/videos_repository.dart';

class VideosRepositoryImpl implements IVideosRepository {
  final VideosRemoteDataSource remoteDataSource;

  VideosRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<VideoEntity>>> getAllModels() async {
    return await remoteDataSource.getAllModels();
  }
}
