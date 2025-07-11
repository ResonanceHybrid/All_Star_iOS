// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:all_star_learning/new/features/student_list/domain/entities/class_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/section_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/student_entity.dart';

class StudentListState {
  final bool isLoading;
  final bool isSuccess;

  final List<ClassEntity> classList;
  final List<StudentEntity> studentList;
  final List<SectionEntity> sectionList;

  final int? selectedClassId;
  final int? selectedSectionId;

  StudentListState({
    required this.isLoading,
    required this.isSuccess,
    required this.classList,
    required this.studentList,
    required this.sectionList,
    this.selectedClassId,
    this.selectedSectionId,
  });

  factory StudentListState.initial() {
    return StudentListState(
      isLoading: false,
      isSuccess: false,
      classList: <ClassEntity>[],
      studentList: <StudentEntity>[],
      sectionList: <SectionEntity>[],
    );
  }

  StudentListState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<ClassEntity>? classList,
    List<StudentEntity>? studentList,
    List<SectionEntity>? sectionList,
    ValueGetter<int?>? selectedClassId,
    ValueGetter<int?>? selectedSectionId,
  }) {
    return StudentListState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      classList: classList ?? this.classList,
      studentList: studentList ?? this.studentList,
      sectionList: sectionList ?? this.sectionList,
      selectedClassId:
          selectedClassId != null ? selectedClassId() : this.selectedClassId,
      selectedSectionId: selectedSectionId != null
          ? selectedSectionId()
          : this.selectedSectionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_loading': isLoading,
      'is_success': isSuccess,
      'class_list': classList.map((x) => x.toMap()).toList(),
      'student_list': studentList.map((x) => x.toMap()).toList(),
      'section_list': sectionList.map((x) => x.toMap()).toList(),
      'selected_class_id': selectedClassId,
      'selected_section_id': selectedSectionId,
    };
  }

  factory StudentListState.fromMap(Map<String, dynamic> map) {
    return StudentListState(
      isLoading: map['is_loading'] ?? false,
      isSuccess: map['is_success'] ?? false,
      classList: List<ClassEntity>.from(
          map['class_list']?.map((x) => ClassEntity.fromMap(x)) ?? const []),
      studentList: List<StudentEntity>.from(
          map['student_list']?.map((x) => StudentEntity.fromMap(x)) ??
              const []),
      sectionList: List<SectionEntity>.from(
          map['section_list']?.map((x) => SectionEntity.fromMap(x)) ??
              const []),
      selectedClassId: map['selected_class_id']?.toInt(),
      selectedSectionId: map['selected_section_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentListState.fromJson(String source) =>
      StudentListState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentListState(isLoading: $isLoading, isSuccess: $isSuccess, classList: $classList, studentList: $studentList, sectionList: $sectionList, selectedClassId: $selectedClassId, selectedSectionId: $selectedSectionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentListState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.classList, classList) &&
        listEquals(other.studentList, studentList) &&
        listEquals(other.sectionList, sectionList) &&
        other.selectedClassId == selectedClassId &&
        other.selectedSectionId == selectedSectionId;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        classList.hashCode ^
        studentList.hashCode ^
        sectionList.hashCode ^
        selectedClassId.hashCode ^
        selectedSectionId.hashCode;
  }
}
