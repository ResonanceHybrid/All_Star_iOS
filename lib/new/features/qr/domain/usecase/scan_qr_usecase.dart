import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/scan_studnet_response_entity.dart';
import 'package:all_star_learning/new/features/qr/domain/repository/qr_repository.dart';
import 'package:dartz/dartz.dart';

class ScanQrUseCase extends Usecase<ScanStudentResponseEntity, ScanQrParams> {
  final IQrRepository repository;

  ScanQrUseCase(this.repository);

  @override
  Future<Either<AppErrorHandler, ScanStudentResponseEntity>> call(
      ScanQrParams params) async {
    return await repository.scanQR(userID: params.userID, type: params.type);
  }
}

class ScanQrParams {
  final String userID;
  final String type;

  ScanQrParams({required this.userID, required this.type});
}
