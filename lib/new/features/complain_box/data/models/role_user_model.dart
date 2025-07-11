// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';

class RoleUserModel extends RoleUserEntity {
  RoleUserModel({
    super.id,
    super.name,
    super.slug,
    super.createdAt,
    super.updatedAt,
  });

  @override
  RoleUserModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? createdAt,
    String? updatedAt,
  }) {
    return RoleUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory RoleUserModel.fromMap(Map<String, dynamic> map) {
    return RoleUserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RoleUserModel.fromJson(String source) =>
      RoleUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoleUserModel(id: $id, name: $name, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant RoleUserModel other) {
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

  static List<RoleUserModel> fromListMap(List<dynamic> data) {
    return data.map((e) => RoleUserModel.fromMap(e)).toList();
  }
}
