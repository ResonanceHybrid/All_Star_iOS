
import 'package:flutter/foundation.dart';

import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_entity.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_routine_entity.dart';

class ExamRoutineState {
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? error;

  final ExamRoutineEntity? examRoutineEntity;
  final List<ExamEntity>? examEntityList;

  final ExamEntity? selectedExam;

  final String? selectedClass;
  final List<ClassModel> classList;
  ExamRoutineState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.examRoutineEntity,
    this.examEntityList,
    this.selectedExam,
    this.selectedClass,
    required this.classList,
  });

  factory ExamRoutineState.initial() {
    return ExamRoutineState(
      classList: [],
      isLoading: false,
      isSuccess: false,
      error: null,
      examRoutineEntity: null,
      examEntityList: null,
    );
  }

  ExamRoutineState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<AppErrorHandler?>? error,
    ValueGetter<ExamRoutineEntity?>? examRoutineEntity,
    ValueGetter<List<ExamEntity>?>? examEntityList,
    ValueGetter<ExamEntity?>? selectedExam,
    ValueGetter<String?>? selectedClass,
    List<ClassModel>? classList,
  }) {
    return ExamRoutineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error != null ? error() : this.error,
      examRoutineEntity: examRoutineEntity != null
          ? examRoutineEntity()
          : this.examRoutineEntity,
      examEntityList:
          examEntityList != null ? examEntityList() : this.examEntityList,
      selectedExam: selectedExam != null ? selectedExam() : this.selectedExam,
      selectedClass:
          selectedClass != null ? selectedClass() : this.selectedClass,
      classList: classList ?? this.classList,
    );
  }

  @override
  String toString() {
    return 'ExamRoutineState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, examRoutineEntity: $examRoutineEntity, examEntityList: $examEntityList, selectedExam: $selectedExam, selectedClass: $selectedClass, classList: $classList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamRoutineState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        other.examRoutineEntity == examRoutineEntity &&
        listEquals(other.examEntityList, examEntityList) &&
        other.selectedExam == selectedExam &&
        other.selectedClass == selectedClass &&
        listEquals(other.classList, classList);
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        examRoutineEntity.hashCode ^
        examEntityList.hashCode ^
        selectedExam.hashCode ^
        selectedClass.hashCode ^
        classList.hashCode;
  }
}
