
    import 'dart:convert';
    
    class SectionEntity {
  final int? id;
  final String? name;
  final bool? isClassTeacher;
SectionEntity({
    this.id,
    this.name,
    this.isClassTeacher,
  });
  SectionEntity copyWith({
    int? id,
    String? name,
    bool? isClassTeacher,
  }) {
    return SectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isClassTeacher: isClassTeacher ?? this.isClassTeacher,
    );
  }
  @override
  String toString() {
    return 'SectionEntity {"id": $id, "name": $name, "isClassTeacher": $isClassTeacher, }';
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_class_teacher': isClassTeacher,
    };
  }
  factory SectionEntity.fromMap(Map<String, dynamic> map) {
    return SectionEntity(
      id:map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      isClassTeacher: map['is_class_teacher'],
    );
  }
  

String toJson() => json.encode(toMap());

  factory SectionEntity.fromJson(String source) =>
    SectionEntity.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  bool operator ==(covariant SectionEntity other) {
    if (identical(this, other)) return true;
    return   id == other.id &&
   name == other.name &&
   isClassTeacher == other.isClassTeacher;
  }
  @override
  int get hashCode {
    return id.hashCode ^
name.hashCode ^
isClassTeacher.hashCode;
  }
}

