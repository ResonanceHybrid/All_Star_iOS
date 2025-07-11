import 'dart:convert';

import 'package:flutter/widgets.dart';

class RepliesEntity {
  final int? id;
  final String? description;
  final String? createdBy;
  final String? role;
  final String? createdAt;
  RepliesEntity({
    this.id,
    this.description,
    this.createdBy,
    this.role,
    this.createdAt,
  });
  RepliesEntity copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? description,
    ValueGetter<String?>? createdBy,
    ValueGetter<String?>? role,
    ValueGetter<String?>? createdAt,
  }) {
    return RepliesEntity(
      id: id != null ? id() : this.id,
      description: description != null ? description() : this.description,
      createdBy: createdBy != null ? createdBy() : this.createdBy,
      role: role != null ? role() : this.role,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  @override
  String toString() {
    return 'RepliesEntity(id: $id, description: $description, createdBy: $createdBy, role: $role, createdAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'created_by': createdBy,
      'role': role,
      'created_at': createdAt,
    };
  }

  factory RepliesEntity.fromMap(Map<String, dynamic> map) {
    return RepliesEntity(
      id: map['id']?.toInt(),
      description: map['description'],
      createdBy: map['created_by'],
      role: map['role'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RepliesEntity.fromJson(String source) =>
      RepliesEntity.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RepliesEntity &&
        other.id == id &&
        other.description == description &&
        other.createdBy == createdBy &&
        other.role == role &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        createdBy.hashCode ^
        role.hashCode ^
        createdAt.hashCode;
  }
}
