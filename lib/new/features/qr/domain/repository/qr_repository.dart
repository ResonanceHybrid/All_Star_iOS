import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/scan_studnet_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IQrRepository {
  Future<Either<AppErrorHandler, List<QRAttendanceTypeEntity>>> getScanType({
    bool report = true,
    bool student = false,
  });
  Future<Either<AppErrorHandler, ScanStudentResponseEntity>> scanQR({
    required String userID,
    required String type,
  });
  Future<Either<AppErrorHandler, String>> getStudentQrReport({
    required int monthId,
  });
}
