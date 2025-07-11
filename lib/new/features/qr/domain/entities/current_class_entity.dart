import 'dart:convert';
import 'package:all_star_learning/new/features/qr/domain/entities/class_entity.dart';

import 'section_entity.dart';

class CurrentClassEntity {
  final int? id;
  final int? studentId;
  final int? classId;
  final int? sectionId;
  final int? academicYearId;
  final dynamic admissionDate;
  final int? rollNo;
  final int? totalAdvance;
  final int? isActive;
  final dynamic deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final dynamic isPass;
  final dynamic symbolNo;
  final String? newOldKey;
  final int? sessionYearId;
  final ClassEntity? classEntity;
  final SectionEntity? section;
  CurrentClassEntity({
    this.id,
    this.studentId,
    this.classId,
    this.sectionId,
    this.academicYearId,
    this.admissionDate,
    this.rollNo,
    this.totalAdvance,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isPass,
    this.symbolNo,
    this.newOldKey,
    this.sessionYearId,
    this.classEntity,
    this.section,
  });
  CurrentClassEntity copyWith({
    int? id,
    int? studentId,
    int? classId,
    int? sectionId,
    int? academicYearId,
    dynamic admissionDate,
    int? rollNo,
    int? totalAdvance,
    int? isActive,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    dynamic isPass,
    dynamic symbolNo,
    String? newOldKey,
    int? sessionYearId,
    ClassEntity? classEntity,
    SectionEntity? section,
  }) {
    return CurrentClassEntity(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      sectionId: sectionId ?? this.sectionId,
      academicYearId: academicYearId ?? this.academicYearId,
      admissionDate: admissionDate ?? this.admissionDate,
      rollNo: rollNo ?? this.rollNo,
      totalAdvance: totalAdvance ?? this.totalAdvance,
      isActive: isActive ?? this.isActive,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPass: isPass ?? this.isPass,
      symbolNo: symbolNo ?? this.symbolNo,
      newOldKey: newOldKey ?? this.newOldKey,
      sessionYearId: sessionYearId ?? this.sessionYearId,
      classEntity: classEntity ?? this.classEntity,
      section: section ?? section,
    );
  }

  @override
  String toString() {
    return 'CurrentClassEntity {"id": $id, "studentId": $studentId, "classId": $classId, "sectionId": $sectionId, "academicYearId": $academicYearId, "admissionDate": $admissionDate, "rollNo": $rollNo, "totalAdvance": $totalAdvance, "isActive": $isActive, "deletedAt": $deletedAt, "createdAt": $createdAt, "updatedAt": $updatedAt, "isPass": $isPass, "symbolNo": $symbolNo, "newOldKey": $newOldKey, "sessionYearId": $sessionYearId, "classEntity": $classEntity, "section": $section, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'class_id': classId,
      'section_id': sectionId,
      'academic_year_id': academicYearId,
      'admission_date': admissionDate,
      'roll_no': rollNo,
      'total_advance': totalAdvance,
      'is_active': isActive,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_pass': isPass,
      'symbol_no': symbolNo,
      'new_old_key': newOldKey,
      'session_year_id': sessionYearId,
      'class': classEntity?.toMap(),
      'section': section?.toMap(),
    };
  }

  factory CurrentClassEntity.fromMap(Map<String, dynamic> map) {
    return CurrentClassEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      studentId:
          map['student_id'] != null ? int.parse("${map['student_id']}") : null,
      classId: map['class_id'] != null ? int.parse("${map['class_id']}") : null,
      sectionId:
          map['section_id'] != null ? int.parse("${map['section_id']}") : null,
      academicYearId: map['academic_year_id'] != null
          ? int.parse("${map['academic_year_id']}")
          : null,
      admissionDate: map['admission_date'],
      rollNo: map['roll_no'] != null ? int.parse("${map['roll_no']}") : null,
      totalAdvance: map['total_advance'] != null
          ? int.parse("${map['total_advance']}")
          : null,
      isActive:
          map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      deletedAt: map['deleted_at'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      isPass: map['is_pass'],
      symbolNo: map['symbol_no'],
      newOldKey: map['new_old_key'],
      sessionYearId: map['session_year_id'] != null
          ? int.parse("${map['session_year_id']}")
          : null,
      classEntity:
          map['class'] != null ? ClassEntity.fromMap(map['class']) : null,
      section:
          map['section'] != null ? SectionEntity.fromMap(map['section']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentClassEntity.fromJson(String source) =>
      CurrentClassEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CurrentClassEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        studentId == other.studentId &&
        classId == other.classId &&
        sectionId == other.sectionId &&
        academicYearId == other.academicYearId &&
        admissionDate == other.admissionDate &&
        rollNo == other.rollNo &&
        totalAdvance == other.totalAdvance &&
        isActive == other.isActive &&
        deletedAt == other.deletedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isPass == other.isPass &&
        symbolNo == other.symbolNo &&
        newOldKey == other.newOldKey &&
        sessionYearId == other.sessionYearId &&
        classEntity == other.classEntity &&
        section == other.section;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        classId.hashCode ^
        sectionId.hashCode ^
        academicYearId.hashCode ^
        admissionDate.hashCode ^
        rollNo.hashCode ^
        totalAdvance.hashCode ^
        isActive.hashCode ^
        deletedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isPass.hashCode ^
        symbolNo.hashCode ^
        newOldKey.hashCode ^
        sessionYearId.hashCode ^
        classEntity.hashCode ^
        section.hashCode;
  }
}
