// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';

class LeaveState {
  final bool isLoading;
  final bool isSuccess;

  final List<LeaveEntity> leaves;
  final String toDate;
  final String fromDate;
  LeaveState({
    required this.isLoading,
    required this.isSuccess,
    required this.leaves,
    required this.toDate,
    required this.fromDate,
  });

  factory LeaveState.initial() {
    return LeaveState(
      isLoading: false,
      isSuccess: false,
      leaves: <LeaveEntity>[],
      toDate:
          "${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}",
      fromDate:
          "${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}",
    );
  }

  LeaveState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<LeaveEntity>? leaves,
    String? toDate,
    String? fromDate,
  }) {
    return LeaveState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      leaves: leaves ?? this.leaves,
      toDate: toDate ?? this.toDate,
      fromDate: fromDate ?? this.fromDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'leaves': leaves.map((x) => x.toMap()).toList(),
      'toDate': toDate,
      'fromDate': fromDate,
    };
  }

  factory LeaveState.fromMap(Map<String, dynamic> map) {
    return LeaveState(
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      leaves: List<LeaveEntity>.from(
        (map['leaves'] as List<int>).map<LeaveEntity>(
          (x) => LeaveEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      toDate: map['toDate'] as String,
      fromDate: map['fromDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveState.fromJson(String source) =>
      LeaveState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeaveState(isLoading: $isLoading, isSuccess: $isSuccess, leaves: $leaves, toDate: $toDate, fromDate: $fromDate)';
  }

  @override
  bool operator ==(covariant LeaveState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.leaves, leaves) &&
        other.toDate == toDate &&
        other.fromDate == fromDate;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        leaves.hashCode ^
        toDate.hashCode ^
        fromDate.hashCode;
  }
}
