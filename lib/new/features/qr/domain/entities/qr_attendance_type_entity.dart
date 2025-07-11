import 'dart:convert';

import 'package:flutter/widgets.dart';

class QRAttendanceTypeEntity {
  final int? id;
  final String? name;
  final String? slug;
  QRAttendanceTypeEntity({
    this.id,
    this.name,
    this.slug,
  });

  QRAttendanceTypeEntity copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? slug,
  }) {
    return QRAttendanceTypeEntity(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      slug: slug != null ? slug() : this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory QRAttendanceTypeEntity.fromMap(Map<String, dynamic> map) {
    return QRAttendanceTypeEntity(
      id: map['id']?.toInt(),
      name: map['name'],
      slug: map['slug'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QRAttendanceTypeEntity.fromJson(String source) =>
      QRAttendanceTypeEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'QRAttendanceTypeEntity(id: $id, name: $name, slug: $slug)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRAttendanceTypeEntity &&
        other.id == id &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;

  static List<QRAttendanceTypeEntity> fromListMap(List<dynamic> data) {
    return data.map((e) => QRAttendanceTypeEntity.fromMap(e)).toList();
  }
}
