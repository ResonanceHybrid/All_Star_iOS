import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ExamEntity {
  final int? id;
  final int? academicYearId;
  final String? name;
  final String? shortName;
  final String? rank;
  final String? workingDaysFrom;
  final String? workingDaysTo;
  final String? totalWorkingDays;
  final String? totalHolidays;
  final int? isActive;
  final int? isFinal;
  final int? createdBy;
  final dynamic updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final int? sessionYearId;
  ExamEntity({
    this.id,
    this.academicYearId,
    this.name,
    this.shortName,
    this.rank,
    this.workingDaysFrom,
    this.workingDaysTo,
    this.totalWorkingDays,
    this.totalHolidays,
    this.isActive,
    this.isFinal,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sessionYearId,
  });
  ExamEntity copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? academicYearId,
    ValueGetter<String?>? name,
    ValueGetter<String?>? shortName,
    ValueGetter<String?>? rank,
    ValueGetter<String?>? workingDaysFrom,
    ValueGetter<String?>? workingDaysTo,
    ValueGetter<String?>? totalWorkingDays,
    ValueGetter<String?>? totalHolidays,
    ValueGetter<int?>? isActive,
    ValueGetter<int?>? isFinal,
    ValueGetter<int?>? createdBy,
    ValueGetter<dynamic>? updatedBy,
    ValueGetter<String?>? createdAt,
    ValueGetter<String?>? updatedAt,
    ValueGetter<dynamic>? deletedAt,
    ValueGetter<int?>? sessionYearId,
  }) {
    return ExamEntity(
      id: id != null ? id() : this.id,
      academicYearId:
          academicYearId != null ? academicYearId() : this.academicYearId,
      name: name != null ? name() : this.name,
      shortName: shortName != null ? shortName() : this.shortName,
      rank: rank != null ? rank() : this.rank,
      workingDaysFrom:
          workingDaysFrom != null ? workingDaysFrom() : this.workingDaysFrom,
      workingDaysTo:
          workingDaysTo != null ? workingDaysTo() : this.workingDaysTo,
      totalWorkingDays:
          totalWorkingDays != null ? totalWorkingDays() : this.totalWorkingDays,
      totalHolidays:
          totalHolidays != null ? totalHolidays() : this.totalHolidays,
      isActive: isActive != null ? isActive() : this.isActive,
      isFinal: isFinal != null ? isFinal() : this.isFinal,
      createdBy: createdBy != null ? createdBy() : this.createdBy,
      updatedBy: updatedBy != null ? updatedBy() : this.updatedBy,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
      deletedAt: deletedAt != null ? deletedAt() : this.deletedAt,
      sessionYearId:
          sessionYearId != null ? sessionYearId() : this.sessionYearId,
    );
  }

  @override
  String toString() {
    return 'ExamEntity(id: $id, academicYearId: $academicYearId, name: $name, shortName: $shortName, rank: $rank, workingDaysFrom: $workingDaysFrom, workingDaysTo: $workingDaysTo, totalWorkingDays: $totalWorkingDays, totalHolidays: $totalHolidays, isActive: $isActive, isFinal: $isFinal, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, sessionYearId: $sessionYearId)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'academic_year_id': academicYearId,
      'name': name,
      'short_name': shortName,
      'rank': rank,
      'working_days_from': workingDaysFrom,
      'working_days_to': workingDaysTo,
      'total_working_days': totalWorkingDays,
      'total_holidays': totalHolidays,
      'is_active': isActive,
      'is_final': isFinal,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'session_year_id': sessionYearId,
    };
  }

  factory ExamEntity.fromMap(Map<String, dynamic> map) {
    return ExamEntity(
      id: map['id']?.toInt(),
      academicYearId: map['academic_year_id']?.toInt(),
      name: map['name'],
      shortName: map['short_name'],
      rank: map['rank'],
      workingDaysFrom: map['working_days_from'],
      workingDaysTo: map['working_days_to'],
      totalWorkingDays: map['total_working_days'],
      totalHolidays: map['total_holidays'],
      isActive: map['is_active']?.toInt(),
      isFinal: map['is_final']?.toInt(),
      createdBy: map['created_by']?.toInt(),
      updatedBy: map['updated_by'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
      sessionYearId: map['session_year_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamEntity.fromJson(String source) =>
      ExamEntity.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamEntity &&
        other.id == id &&
        other.academicYearId == academicYearId &&
        other.name == name &&
        other.shortName == shortName &&
        other.rank == rank &&
        other.workingDaysFrom == workingDaysFrom &&
        other.workingDaysTo == workingDaysTo &&
        other.totalWorkingDays == totalWorkingDays &&
        other.totalHolidays == totalHolidays &&
        other.isActive == isActive &&
        other.isFinal == isFinal &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.sessionYearId == sessionYearId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        academicYearId.hashCode ^
        name.hashCode ^
        shortName.hashCode ^
        rank.hashCode ^
        workingDaysFrom.hashCode ^
        workingDaysTo.hashCode ^
        totalWorkingDays.hashCode ^
        totalHolidays.hashCode ^
        isActive.hashCode ^
        isFinal.hashCode ^
        createdBy.hashCode ^
        updatedBy.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        sessionYearId.hashCode;
  }
}
