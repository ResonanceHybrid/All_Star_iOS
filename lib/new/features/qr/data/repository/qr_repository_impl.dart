import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/qr/data/models/qr_attendance_type_model.dart';
import 'package:all_star_learning/new/features/qr/data/models/scan_studnet_response_model.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/qr_remote_data_source.dart';
import '../../domain/repository/qr_repository.dart';

class QrRepositoryImpl implements IQrRepository {
  final QrRemoteDataSource remoteDataSource;

  QrRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<QRAttendanceTypeModel>>> getScanType({
    bool report = true,
    bool student = false,
  }) async {
    return await remoteDataSource.getScanType(
      report: report,
      student: student,
    );
  }

  @override
  Future<Either<AppErrorHandler, ScanStudentResponseModel>> scanQR(
      {required String userID, required String type}) async {
    return await remoteDataSource.scanQR(userID: userID, type: type);
  }

  @override
  Future<Either<AppErrorHandler, String>> getStudentQrReport(
      {required int monthId}) async {
    return await remoteDataSource.getStudentQrReport(monthId: monthId);
  }
}
