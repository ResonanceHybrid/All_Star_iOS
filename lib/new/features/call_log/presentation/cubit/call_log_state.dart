// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:all_star_learning/new/features/call_log/domain/entities/call_log_entity.dart';

class CallLogState {
  final bool isLoading;
  final bool isSuccess;

  final List<CallLogEntity> callLogs;

  final Map<String, List<CallLogEntity>>? dateSortedCallLogs;

  final CallLogEntity? selectedCallLog;

  CallLogState({
    required this.isLoading,
    required this.isSuccess,
    required this.callLogs,
    this.dateSortedCallLogs,
    this.selectedCallLog,
  });

  factory CallLogState.initial() {
    return CallLogState(
      isLoading: false,
      isSuccess: false,
      callLogs: <CallLogEntity>[],
    );
  }

  CallLogState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<CallLogEntity>? callLogs,
    Map<String, List<CallLogEntity>>? dateSortedCallLogs,
    ValueGetter<CallLogEntity>? selectedCallLog,
  }) {
    return CallLogState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      callLogs: callLogs ?? this.callLogs,
      dateSortedCallLogs: dateSortedCallLogs ?? this.dateSortedCallLogs,
      selectedCallLog:
          selectedCallLog != null ? selectedCallLog() : this.selectedCallLog,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'isLoading': isLoading,
  //     'isSuccess': isSuccess,
  //     'callLogs': callLogs.map((x) => x.toMap()).toList(),
  //     'dateSortedCallLogs': dateSortedCallLogs,
  //     'selectedCallLog': selectedCallLog?.toMap(),
  //   };
  // }

  // String toJson() => json.encode(toMap());

  // @override
  // String toString() {
  //   return 'CallLogState(isLoading: $isLoading, isSuccess: $isSuccess, callLogs: $callLogs, dateSortedCallLogs: $dateSortedCallLogs, selectedCallLog: $selectedCallLog)';
  // }

  @override
  bool operator ==(covariant CallLogState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.callLogs, callLogs) &&
        mapEquals(other.dateSortedCallLogs, dateSortedCallLogs) &&
        other.selectedCallLog == selectedCallLog;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        callLogs.hashCode ^
        dateSortedCallLogs.hashCode ^
        selectedCallLog.hashCode;
  }
}
