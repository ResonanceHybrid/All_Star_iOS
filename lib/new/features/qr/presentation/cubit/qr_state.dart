// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/foundation.dart';

import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/scan_studnet_response_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/class_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/section_entity.dart';

class QrState {
  final bool isLoading;
  final bool isSuccess;

  final List<QRAttendanceTypeEntity>? scanTypesEntity;

  final String? selectedType;

  final List<QRAttendanceTypeEntity> selectedTypeList;
  final QRAttendanceTypeEntity? selectedTypeEntity;
  final ClassEntity? selectedClass;
  final SectionEntity? selectedSection;
  final MonthModel? selectedMonth;
  final List<MonthModel> monthList;

  final ScanStudentResponseEntity? scanStudentResponseEntity;

  final bool scanSuccess;
  final AppErrorHandler? error;

  final String? studentQrReport;

  QrState({
    required this.isLoading,
    required this.isSuccess,
    this.scanTypesEntity,
    this.selectedType,
    required this.selectedTypeList,
    this.selectedTypeEntity,
    this.selectedClass,
    this.selectedSection,
    this.selectedMonth,
    required this.monthList,
    this.scanStudentResponseEntity,
    required this.scanSuccess,
    this.error,
    this.studentQrReport,
  });

  factory QrState.initial() {
    return QrState(
      isLoading: false,
      isSuccess: false,
      scanTypesEntity: null,
      selectedType: null,
      selectedTypeList: const [],
      selectedClass: null,
      selectedSection: null,
      selectedMonth: null,
      monthList: const [],
      scanStudentResponseEntity: null,
      scanSuccess: false,
      error: null,
    );
  }

  QrState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<List<QRAttendanceTypeEntity>?>? scanTypesEntity,
    ValueGetter<String?>? selectedType,
    List<QRAttendanceTypeEntity>? selectedTypeList,
    ValueGetter<QRAttendanceTypeEntity?>? selectedTypeEntity,
    ValueGetter<ClassEntity?>? selectedClass,
    ValueGetter<SectionEntity?>? selectedSection,
    ValueGetter<MonthModel?>? selectedMonth,
    List<MonthModel>? monthList,
    ValueGetter<ScanStudentResponseEntity?>? scanStudentResponseEntity,
    bool? scanSuccess,
    ValueGetter<AppErrorHandler?>? error,
    ValueGetter<String?>? studentQrReport,
  }) {
    return QrState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      scanTypesEntity:
          scanTypesEntity != null ? scanTypesEntity() : this.scanTypesEntity,
      selectedType: selectedType != null ? selectedType() : this.selectedType,
      selectedTypeList: selectedTypeList ?? this.selectedTypeList,
      selectedTypeEntity: selectedTypeEntity != null
          ? selectedTypeEntity()
          : this.selectedTypeEntity,
      selectedClass:
          selectedClass != null ? selectedClass() : this.selectedClass,
      selectedSection:
          selectedSection != null ? selectedSection() : this.selectedSection,
      selectedMonth:
          selectedMonth != null ? selectedMonth() : this.selectedMonth,
      monthList: monthList ?? this.monthList,
      scanStudentResponseEntity: scanStudentResponseEntity != null
          ? scanStudentResponseEntity()
          : this.scanStudentResponseEntity,
      scanSuccess: scanSuccess ?? this.scanSuccess,
      error: error != null ? error() : this.error,
      studentQrReport:
          studentQrReport != null ? studentQrReport() : this.studentQrReport,
    );
  }

  @override
  String toString() {
    return 'QrState(isLoading: $isLoading, isSuccess: $isSuccess, scanTypesEntity: $scanTypesEntity, selectedType: $selectedType, selectedTypeList: $selectedTypeList, selectedTypeEntity: $selectedTypeEntity, selectedClass: $selectedClass, selectedSection: $selectedSection, selectedMonth: $selectedMonth, monthList: $monthList, scanStudentResponseEntity: $scanStudentResponseEntity, scanSuccess: $scanSuccess, error: $error, studentQrReport: $studentQrReport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QrState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.scanTypesEntity, scanTypesEntity) &&
        other.selectedType == selectedType &&
        listEquals(other.selectedTypeList, selectedTypeList) &&
        other.selectedTypeEntity == selectedTypeEntity &&
        other.selectedClass == selectedClass &&
        other.selectedSection == selectedSection &&
        other.selectedMonth == selectedMonth &&
        listEquals(other.monthList, monthList) &&
        other.scanStudentResponseEntity == scanStudentResponseEntity &&
        other.scanSuccess == scanSuccess &&
        other.error == error &&
        other.studentQrReport == studentQrReport;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        scanTypesEntity.hashCode ^
        selectedType.hashCode ^
        selectedTypeList.hashCode ^
        selectedTypeEntity.hashCode ^
        selectedClass.hashCode ^
        selectedSection.hashCode ^
        selectedMonth.hashCode ^
        monthList.hashCode ^
        scanStudentResponseEntity.hashCode ^
        scanSuccess.hashCode ^
        error.hashCode ^
        studentQrReport.hashCode;
  }
}
