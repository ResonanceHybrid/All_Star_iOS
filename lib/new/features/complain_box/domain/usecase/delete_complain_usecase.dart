import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/repository/complain_box_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteComplainUsecase extends Usecase<bool, int> {
  final IComplainBoxRepository repository;

  DeleteComplainUsecase({required this.repository});

  @override
  Future<Either<AppErrorHandler, bool>> call(int params) async {
    return await repository.deleteComplain(complainId: params);
  }
}
