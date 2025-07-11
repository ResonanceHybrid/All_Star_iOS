import 'dart:developer';

import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/get_all_qr_usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/get_student_qr_report_usecase.dart';
import 'package:all_star_learning/new/features/qr/domain/usecase/scan_qr_usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/class_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/section_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit({
    required this.getScanTypeUsecase,
    required this.scanQrUseCase,
    required this.getStudentQRReportUsecase,
  }) : super(QrState.initial());

  final GetScanTypeUsecase getScanTypeUsecase;
  final ScanQrUseCase scanQrUseCase;
  final GetStudentQRReportUsecase getStudentQRReportUsecase;

  Future<void> getScanTypes({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    bool report = true,
    bool student = false,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      scanTypesEntity: () => [],
      error: () => null,
    ));
    final result = await getScanTypeUsecase(
      GetScanTypeUsecaseParams(
        report: report,
        student: student,
      ),
    );

    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
        onError?.call(error.message);
      },
      (scanTypes) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          scanTypesEntity: () => scanTypes,
          selectedTypeEntity: () => scanTypes.first,
          selectedTypeList: [],
        ));
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void selectType(String? value) {
    emit(state.copyWith(selectedType: () => value));
  }

  void selectTypeEntity(QRAttendanceTypeEntity? value) {
    emit(state.copyWith(selectedTypeEntity: () => value));
  }

  Future<void> scanQr({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String userID,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final userId = userID.replaceAll("user", '').replaceAll('=', '');

    log("userId: $userId");
    final result = await scanQrUseCase(ScanQrParams(
      userID: userId,
      type: state.selectedType ?? "",
    ));
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            scanSuccess: false,
            error: () => error,
          ),
        );

        onError?.call(error.message);
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            scanStudentResponseEntity: () => success,
            error: () => null,
            scanSuccess: true,
          ),
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> getMonths({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    ApiMethods.getMonths().then((value) {
      if (value is SuccessResponse) {
        emit(state.copyWith(
          monthList: value.data,
        ));
        onSuccess?.call();
        navigation?.call();
      } else {
        onError?.call(value.message!);
      }
    }).catchError((e) {
      onError?.call(e.toString());
    });
  }

  void selectClass({
    required ClassEntity? value,
  }) {
    emit(state.copyWith(selectedClass: () => value));
  }

  void selectSection({
    required SectionEntity? value,
  }) {
    emit(state.copyWith(selectedSection: () => value));
  }

  void selectMonth({
    required MonthModel? value,
  }) {
    emit(state.copyWith(selectedMonth: () => value));
  }

  void selectScanType({
    required QRAttendanceTypeEntity? value,
  }) {
    final List<QRAttendanceTypeEntity> selectedTypeList =
        List<QRAttendanceTypeEntity>.from(state.selectedTypeList);

    // add the selected type to the list
    if (value != null && !selectedTypeList.contains(value)) {
      selectedTypeList.add(value);
    }

    emit(state.copyWith(selectedTypeList: selectedTypeList));
  }

  void clearSelectedScanType() {
    emit(state.copyWith(selectedTypeList: []));
  }

  void removeSelectedType({
    required QRAttendanceTypeEntity value,
  }) {
    final List<QRAttendanceTypeEntity> selectedTypeList =
        List<QRAttendanceTypeEntity>.from(state.selectedTypeList);

    // remove the selected type from the list
    selectedTypeList.remove(value);

    emit(state.copyWith(selectedTypeList: selectedTypeList));
  }

  Future<void> getStudentQrReport({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int monthId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getStudentQRReportUsecase(monthId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            scanSuccess: false,
            error: () => error,
          ),
        );

        onError?.call(error.message);
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            studentQrReport: () => success,
            error: () => null,
            scanSuccess: true,
          ),
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }
}
