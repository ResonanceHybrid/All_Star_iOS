import '../../domain/entities/section_entity.dart';
class SectionModel extends SectionEntity{
SectionModel({
    super.academicYearId,
    super.name,
    super.slug,
    super.rank,
    super.code,
    super.isActive,
    super.createdAt,
    super.updatedAt,
    super.sessionYearId,
  });
  @override
  String toString() {
    return 'SectionModel {"academicYearId": $academicYearId, "name": $name, "slug": $slug, "rank": $rank, "code": $code, "isActive": $isActive, "createdAt": $createdAt, "updatedAt": $updatedAt, "sessionYearId": $sessionYearId, }';
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'academic_year_id': academicYearId,
      'name': name,
      'slug': slug,
      'rank': rank,
      'code': code,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'session_year_id': sessionYearId,
    };
  }
  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      academicYearId:map['academic_year_id'] != null ? int.parse("${map['academic_year_id']}") : null,
      name: map['name'],
      slug: map['slug'],
      rank: map['rank'],
      code: map['code'],
      isActive:map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      sessionYearId:map['session_year_id'] != null ? int.parse("${map['session_year_id']}") : null,
    );
  }
}

