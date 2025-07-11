import 'dart:convert';

import 'package:flutter/widgets.dart';

class RoutineEntity {
  final int? id;
  final String? className;
  final String? subject;
  final String? date;
  final String? createdAt;
  RoutineEntity({
    this.id,
    this.className,
    this.subject,
    this.date,
    this.createdAt,
  });
  RoutineEntity copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? className,
    ValueGetter<String?>? subject,
    ValueGetter<String?>? date,
    ValueGetter<String?>? createdAt,
  }) {
    return RoutineEntity(
      id: id != null ? id() : this.id,
      className: className != null ? className() : this.className,
      subject: subject != null ? subject() : this.subject,
      date: date != null ? date() : this.date,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  @override
  String toString() {
    return 'RoutineEntity(id: $id, className: $className, subject: $subject, date: $date, createdAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'class_name': className,
      'subject': subject,
      'date': date,
      'created_at': createdAt,
    };
  }

  factory RoutineEntity.fromMap(Map<String, dynamic> map) {
    return RoutineEntity(
      id: map['id']?.toInt(),
      className: map['class_name'],
      subject: map['subject'],
      date: map['date'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoutineEntity.fromJson(String source) =>
      RoutineEntity.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoutineEntity &&
        other.id == id &&
        other.className == className &&
        other.subject == subject &&
        other.date == date &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        className.hashCode ^
        subject.hashCode ^
        date.hashCode ^
        createdAt.hashCode;
  }
}
