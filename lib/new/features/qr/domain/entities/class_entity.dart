
    import 'dart:convert';
    
    class ClassEntity {
  final int? id;
  final int? academicYearId;
  final String? name;
  final String? shortName;
  final String? slug;
  final int? rank;
  final int? isActive;
  final int? isCollege;
  final String? createdAt;
  final String? updatedAt;
  final int? sessionYearId;
ClassEntity({
    this.id,
    this.academicYearId,
    this.name,
    this.shortName,
    this.slug,
    this.rank,
    this.isActive,
    this.isCollege,
    this.createdAt,
    this.updatedAt,
    this.sessionYearId,
  });
  ClassEntity copyWith({
    int? id,
    int? academicYearId,
    String? name,
    String? shortName,
    String? slug,
    int? rank,
    int? isActive,
    int? isCollege,
    String? createdAt,
    String? updatedAt,
    int? sessionYearId,
  }) {
    return ClassEntity(
      id: id ?? this.id,
      academicYearId: academicYearId ?? this.academicYearId,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      rank: rank ?? this.rank,
      isActive: isActive ?? this.isActive,
      isCollege: isCollege ?? this.isCollege,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sessionYearId: sessionYearId ?? this.sessionYearId,
    );
  }
  @override
  String toString() {
    return 'ClassEntity {"id": $id, "academicYearId": $academicYearId, "name": $name, "shortName": $shortName, "slug": $slug, "rank": $rank, "isActive": $isActive, "isCollege": $isCollege, "createdAt": $createdAt, "updatedAt": $updatedAt, "sessionYearId": $sessionYearId, }';
  }
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
  factory ClassEntity.fromMap(Map<String, dynamic> map) {
    return ClassEntity(
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
  

String toJson() => json.encode(toMap());

  factory ClassEntity.fromJson(String source) =>
    ClassEntity.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  bool operator ==(covariant ClassEntity other) {
    if (identical(this, other)) return true;
    return   id == other.id &&
   academicYearId == other.academicYearId &&
   name == other.name &&
   shortName == other.shortName &&
   slug == other.slug &&
   rank == other.rank &&
   isActive == other.isActive &&
   isCollege == other.isCollege &&
   createdAt == other.createdAt &&
   updatedAt == other.updatedAt &&
   sessionYearId == other.sessionYearId;
  }
  @override
  int get hashCode {
    return id.hashCode ^
academicYearId.hashCode ^
name.hashCode ^
shortName.hashCode ^
slug.hashCode ^
rank.hashCode ^
isActive.hashCode ^
isCollege.hashCode ^
createdAt.hashCode ^
updatedAt.hashCode ^
sessionYearId.hashCode;
  }
}

