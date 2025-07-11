import 'package:all_star_learning/new/core/dependency_injection/dependency_injection.dart';
import 'package:all_star_learning/new/features/qr/data/data_source/remote/qr_remote_data_source.dart';
import 'package:all_star_learning/new/features/qr/data/repository/qr_repository_impl.dart';
import 'package:all_star_learning/new/features/qr/domain/repository/qr_repository.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/get_all_qr_usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/get_student_qr_report_usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/scan_qr_usecase.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';

class QRDI {
  void register() {
    locator.registerFactory(() => QrRemoteDataSource(api: locator()));
    locator.registerFactory<IQrRepository>(() => QrRepositoryImpl(
          remoteDataSource: locator(),
        ));
    locator.registerFactory(() => GetScanTypeUsecase(locator()));
    locator.registerFactory(() => ScanQrUseCase(locator()));
    locator.registerFactory(() => GetStudentQRReportUsecase(locator()));

    locator.registerLazySingleton(() => QrCubit(
          getScanTypeUsecase: locator(),
          scanQrUseCase: locator(),
          getStudentQRReportUsecase: locator(),
        ));
  }
}
