import '../../domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    super.id,
    super.academicYearId,
    super.name,
    super.shortName,
    super.rank,
    super.workingDaysFrom,
    super.workingDaysTo,
    super.totalWorkingDays,
    super.totalHolidays,
    super.isActive,
    super.isFinal,
    super.createdBy,
    super.updatedBy,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.sessionYearId,
  });
  @override
  String toString() {
    return 'ExamModel {"id": $id, "academicYearId": $academicYearId, "name": $name, "shortName": $shortName, "rank": $rank, "workingDaysFrom": $workingDaysFrom, "workingDaysTo": $workingDaysTo, "totalWorkingDays": $totalWorkingDays, "totalHolidays": $totalHolidays, "isActive": $isActive, "isFinal": $isFinal, "createdBy": $createdBy, "updatedBy": $updatedBy, "createdAt": $createdAt, "updatedAt": $updatedAt, "deletedAt": $deletedAt, "sessionYearId": $sessionYearId, }';
  }

  @override
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

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      academicYearId: map['academic_year_id'] != null
          ? int.parse("${map['academic_year_id']}")
          : null,
      name: map['name'],
      shortName: map['short_name'],
      rank: map['rank'],
      workingDaysFrom: map['working_days_from'],
      workingDaysTo: map['working_days_to'],
      totalWorkingDays: map['total_working_days'],
      totalHolidays: map['total_holidays'],
      isActive:
          map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      isFinal: map['is_final'] != null ? int.parse("${map['is_final']}") : null,
      createdBy:
          map['created_by'] != null ? int.parse("${map['created_by']}") : null,
      updatedBy: map['updated_by'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
      sessionYearId: map['session_year_id'] != null
          ? int.parse("${map['session_year_id']}")
          : null,
    );
  }
  static List<ExamModel> fromListMap(List<dynamic> data) {
    List<ExamModel> list = [];
    for (var item in data) {
      list.add(ExamModel.fromMap(item));
    }
    return list;
  }
}
