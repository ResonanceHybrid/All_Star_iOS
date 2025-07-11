import '../../domain/entities/class_entity.dart';
class ClassModel extends ClassEntity{
ClassModel({
    super.id,
    super.academicYearId,
    super.name,
    super.shortName,
    super.slug,
    super.rank,
    super.isActive,
    super.isCollege,
    super.createdAt,
    super.updatedAt,
    super.sessionYearId,
  });
  @override
  String toString() {
    return 'ClassModel {"id": $id, "academicYearId": $academicYearId, "name": $name, "shortName": $shortName, "slug": $slug, "rank": $rank, "isActive": $isActive, "isCollege": $isCollege, "createdAt": $createdAt, "updatedAt": $updatedAt, "sessionYearId": $sessionYearId, }';
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'academic_year_id': academicYearId,
      'name': name,
      'short_name': shortName,
      'slug': slug,
      'rank': rank,
      'is_active': isActive,
      'is_college': isCollege,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'session_year_id': sessionYearId,
    };
  }
  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id:map['id'] != null ? int.parse("${map['id']}") : null,
      academicYearId:map['academic_year_id'] != null ? int.parse("${map['academic_year_id']}") : null,
      name: map['name'],
      shortName: map['short_name'],
      slug: map['slug'],
      rank:map['rank'] != null ? int.parse("${map['rank']}") : null,
      isActive:map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      isCollege:map['is_college'] != null ? int.parse("${map['is_college']}") : null,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      sessionYearId:map['session_year_id'] != null ? int.parse("${map['session_year_id']}") : null,
    );
  }
}

