import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/core/usecase/usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/repository/qr_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentQRReportUsecase extends Usecase<String, int> {
  final IQrRepository repository;

  GetStudentQRReportUsecase(this.repository);

  @override
  Future<Either<AppErrorHandler, String>> call(int params) async {
    return await repository.getStudentQrReport(
      monthId: params,
    );
  }
}
