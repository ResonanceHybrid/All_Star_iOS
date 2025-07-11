import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/videos/domain/entities/video_entity.dart';
import 'package:all_star_learning/new/features/videos/domain/repository/videos_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllVideosUsecase extends Usecase<List<VideoEntity>, void> {
  final IVideosRepository repository;

  GetAllVideosUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, List<VideoEntity>>> call(void params) async {
    return await repository.getAllModels();
  }
}
