
    import 'dart:convert';
    
    class SectionEntity {
  final int? academicYearId;
  final String? name;
  final String? slug;
  final dynamic rank;
  final dynamic code;
  final int? isActive;
  final String? createdAt;
  final String? updatedAt;
  final int? sessionYearId;
SectionEntity({
    this.academicYearId,
    this.name,
    this.slug,
    this.rank,
    this.code,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.sessionYearId,
  });
  SectionEntity copyWith({
    int? academicYearId,
    String? name,
    String? slug,
    dynamic rank,
    dynamic code,
    int? isActive,
    String? createdAt,
    String? updatedAt,
    int? sessionYearId,
  }) {
    return SectionEntity(
      academicYearId: academicYearId ?? this.academicYearId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      rank: rank ?? this.rank,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sessionYearId: sessionYearId ?? this.sessionYearId,
    );
  }
  @override
  String toString() {
    return 'SectionEntity {"academicYearId": $academicYearId, "name": $name, "slug": $slug, "rank": $rank, "code": $code, "isActive": $isActive, "createdAt": $createdAt, "updatedAt": $updatedAt, "sessionYearId": $sessionYearId, }';
  }
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
  factory SectionEntity.fromMap(Map<String, dynamic> map) {
    return SectionEntity(
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
  

String toJson() => json.encode(toMap());

  factory SectionEntity.fromJson(String source) =>
    SectionEntity.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  bool operator ==(covariant SectionEntity other) {
    if (identical(this, other)) return true;
    return   academicYearId == other.academicYearId &&
   name == other.name &&
   slug == other.slug &&
   rank == other.rank &&
   code == other.code &&
   isActive == other.isActive &&
   createdAt == other.createdAt &&
   updatedAt == other.updatedAt &&
   sessionYearId == other.sessionYearId;
  }
  @override
  int get hashCode {
    return academicYearId.hashCode ^
name.hashCode ^
slug.hashCode ^
rank.hashCode ^
code.hashCode ^
isActive.hashCode ^
createdAt.hashCode ^
updatedAt.hashCode ^
sessionYearId.hashCode;
  }
}

