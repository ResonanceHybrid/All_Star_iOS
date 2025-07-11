// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoleUserEntity {
  final int? id;
  final String? name;
  final String? slug;
  final String? createdAt;
  final String? updatedAt;
  RoleUserEntity({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  RoleUserEntity copyWith({
    int? id,
    String? name,
    String? slug,
    String? createdAt,
    String? updatedAt,
  }) {
    return RoleUserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory RoleUserEntity.fromMap(Map<String, dynamic> map) {
    return RoleUserEntity(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleUserEntity.fromJson(String source) =>
      RoleUserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoleUserEntity(id: $id, name: $name, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant RoleUserEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
