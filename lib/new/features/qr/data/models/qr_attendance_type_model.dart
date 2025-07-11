import 'dart:convert';

import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:flutter/widgets.dart';

class QRAttendanceTypeModel extends QRAttendanceTypeEntity {
  QRAttendanceTypeModel({
    super.id,
    super.name,
    super.slug,
  });

  @override
  QRAttendanceTypeModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? name,
    ValueGetter<String?>? slug,
  }) {
    return QRAttendanceTypeModel(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      slug: slug != null ? slug() : this.slug,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory QRAttendanceTypeModel.fromMap(Map<String, dynamic> map) {
    return QRAttendanceTypeModel(
      id: map['id']?.toInt(),
      name: map['name'],
      slug: map['slug'],
    );
  }
  factory QRAttendanceTypeModel.fromMap2(Map<String, dynamic> map) {
    return QRAttendanceTypeModel(
      id: map['id']?.toInt(),
      name: map['title'],
      slug: map['slug'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory QRAttendanceTypeModel.fromJson(String source) =>
      QRAttendanceTypeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'QRAttendanceTypeModel(id: $id, name: $name, slug: $slug)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QRAttendanceTypeModel &&
        other.id == id &&
        other.name == name &&
        other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;

  static List<QRAttendanceTypeModel> fromListMap({
    required List<dynamic> data,
    bool student = false,
  }) {
    if (student) {
      return data.map((e) => QRAttendanceTypeModel.fromMap2(e)).toList();
    }
    return data.map((e) => QRAttendanceTypeModel.fromMap(e)).toList();
  }
}
