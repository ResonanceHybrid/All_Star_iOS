import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/domain/repository/qr_repository.dart';
import 'package:dartz/dartz.dart';

class GetScanTypeUsecase
    extends Usecase<List<QRAttendanceTypeEntity>, GetScanTypeUsecaseParams> {
  final IQrRepository repository;

  GetScanTypeUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, List<QRAttendanceTypeEntity>>> call(
      GetScanTypeUsecaseParams params) async {
    return await repository.getScanType(
      report: params.report ?? false,
      student: params.student ?? false,
    );
  }
}

class GetScanTypeUsecaseParams {
  final bool? report;
  final bool? student;

  GetScanTypeUsecaseParams({
    this.report,
    this.student,
  });
}
