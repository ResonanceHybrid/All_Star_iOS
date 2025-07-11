import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/videos/domain/entities/video_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IVideosRepository {
  Future<Either<AppErrorHandler, List<VideoEntity>>> getAllModels();
}
