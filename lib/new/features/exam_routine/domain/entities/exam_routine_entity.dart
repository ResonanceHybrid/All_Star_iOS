import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'routine_entity.dart';

class ExamRoutineEntity {
  final String? exam;
  final List<RoutineEntity>? routine;
  ExamRoutineEntity({
    this.exam,
    this.routine,
  });
  ExamRoutineEntity copyWith({
    ValueGetter<String?>? exam,
    ValueGetter<List<RoutineEntity>?>? routine,
  }) {
    return ExamRoutineEntity(
      exam: exam != null ? exam() : this.exam,
      routine: routine != null ? routine() : this.routine,
    );
  }

  @override
  String toString() => 'ExamRoutineEntity(exam: $exam, routine: $routine)';

  Map<String, dynamic> toMap() {
    return {
      'exam': exam,
      'routine': routine?.map((x) => x.toMap()).toList(),
    };
  }

  factory ExamRoutineEntity.fromMap(Map<String, dynamic> map) {
    return ExamRoutineEntity(
      exam: map['exam'],
      routine: map['routine'] != null
          ? List<RoutineEntity>.from(
              map['routine']?.map((x) => RoutineEntity.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamRoutineEntity.fromJson(String source) =>
      ExamRoutineEntity.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamRoutineEntity &&
        other.exam == exam &&
        listEquals(other.routine, routine);
  }

  @override
  int get hashCode => exam.hashCode ^ routine.hashCode;
}
