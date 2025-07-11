import '../../domain/entities/current_class_entity.dart';
import 'class_model.dart';
import 'section_model.dart';
class CurrentClassModel extends CurrentClassEntity{
CurrentClassModel({
    super.id,
    super.studentId,
    super.classId,
    super.sectionId,
    super.academicYearId,
    super.admissionDate,
    super.rollNo,
    super.totalAdvance,
    super.isActive,
    super.deletedAt,
    super.createdAt,
    super.updatedAt,
    super.isPass,
    super.symbolNo,
    super.newOldKey,
    super.sessionYearId,
    super.classEntity,
    super.section,
  });
  @override
  String toString() {
    return 'CurrentClassModel {"id": $id, "studentId": $studentId, "classId": $classId, "sectionId": $sectionId, "academicYearId": $academicYearId, "admissionDate": $admissionDate, "rollNo": $rollNo, "totalAdvance": $totalAdvance, "isActive": $isActive, "deletedAt": $deletedAt, "createdAt": $createdAt, "updatedAt": $updatedAt, "isPass": $isPass, "symbolNo": $symbolNo, "newOldKey": $newOldKey, "sessionYearId": $sessionYearId, "class": $classEntity, "section": $section, }';
  }
  @override
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
  factory CurrentClassModel.fromMap(Map<String, dynamic> map) {
    return CurrentClassModel(
      id:map['id'] != null ? int.parse("${map['id']}") : null,
      studentId:map['student_id'] != null ? int.parse("${map['student_id']}") : null,
      classId:map['class_id'] != null ? int.parse("${map['class_id']}") : null,
      sectionId:map['section_id'] != null ? int.parse("${map['section_id']}") : null,
      academicYearId:map['academic_year_id'] != null ? int.parse("${map['academic_year_id']}") : null,
      admissionDate: map['admission_date'],
      rollNo:map['roll_no'] != null ? int.parse("${map['roll_no']}") : null,
      totalAdvance:map['total_advance'] != null ? int.parse("${map['total_advance']}") : null,
      isActive:map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      deletedAt: map['deleted_at'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      isPass: map['is_pass'],
      symbolNo: map['symbol_no'],
      newOldKey: map['new_old_key'],
      sessionYearId:map['session_year_id'] != null ? int.parse("${map['session_year_id']}") : null,
      classEntity:map['class'] !=null ? ClassModel.fromMap(map['class']): null,
      section:map['section'] !=null ? SectionModel.fromMap(map['section']): null,
    );
  }
}

