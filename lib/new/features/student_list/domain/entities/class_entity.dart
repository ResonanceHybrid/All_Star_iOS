import 'dart:convert';

class ClassEntity {
  final int? id;
  final String? name;
  final String? shortName;
  final int? rank;
  final bool? isClassTeacher;
  ClassEntity({
    this.id,
    this.name,
    this.shortName,
    this.rank,
    this.isClassTeacher,
  });
  ClassEntity copyWith({
    int? id,
    String? name,
    String? shortName,
    int? rank,
    bool? isClassTeacher,
  }) {
    return ClassEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      rank: rank ?? this.rank,
      isClassTeacher: isClassTeacher ?? this.isClassTeacher,
    );
  }

  @override
  String toString() {
    return 'ClassEntity {"id": $id, "name": $name, "shortName": $shortName, "rank": $rank, "isClassTeacher": $isClassTeacher, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'rank': rank,
      'is_class_teacher': isClassTeacher,
    };
  }

  factory ClassEntity.fromMap(Map<String, dynamic> map) {
    return ClassEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      shortName: map['short_name'],
      rank: map['rank'] != null ? int.parse("${map['rank']}") : null,
      isClassTeacher: map['is_class_teacher'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassEntity.fromJson(String source) =>
      ClassEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ClassEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        name == other.name &&
        shortName == other.shortName &&
        rank == other.rank &&
        isClassTeacher == other.isClassTeacher;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        shortName.hashCode ^
        rank.hashCode ^
        isClassTeacher.hashCode;
  }
}
