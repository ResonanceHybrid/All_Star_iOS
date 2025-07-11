import 'dart:convert';

class CallLogEntity {
  final String? callBy;
  final String? callTo;
  final String? date;
  final String? time;
  final dynamic followupDate;
  final String? phone;
  final int? duration;
  final String? callType;
  final String? purpose;
  final String? remarks;
  final String? behavior;
  CallLogEntity({
    this.callBy,
    this.callTo,
    this.date,
    this.time,
    this.followupDate,
    this.phone,
    this.duration,
    this.callType,
    this.purpose,
    this.remarks,
    this.behavior,
  });
  CallLogEntity copyWith({
    String? callBy,
    String? callTo,
    String? date,
    String? time,
    dynamic followupDate,
    String? phone,
    int? duration,
    String? callType,
    String? purpose,
    String? remarks,
    String? behavior,
  }) {
    return CallLogEntity(
      callBy: callBy ?? this.callBy,
      callTo: callTo ?? this.callTo,
      date: date ?? this.date,
      time: time ?? this.time,
      followupDate: followupDate ?? this.followupDate,
      phone: phone ?? this.phone,
      duration: duration ?? this.duration,
      callType: callType ?? this.callType,
      purpose: purpose ?? this.purpose,
      remarks: remarks ?? this.remarks,
      behavior: behavior ?? this.behavior,
    );
  }

  // @override
  // String toString() {
  //   return 'CallLogEntity {"callBy": $callBy, "callTo": $callTo, "date": $date, "time": $time, "followupDate": $followupDate, "phone": $phone, "duration": $duration, "callType": $callType, "purpose": $purpose, "remarks": $remarks, }';
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'call_by': callBy,
  //     'call_to': callTo,
  //     'date': date,
  //     'time': time,
  //     'followup_date': followupDate,
  //     'phone': phone,
  //     'duration': duration,
  //     'call_type': callType,
  //     'purpose': purpose,
  //     'remarks': remarks,
  //   };
  // }

  factory CallLogEntity.fromMap(Map<String, dynamic> map) {
    return CallLogEntity(
      callBy: map['call_by'],
      callTo: map['call_to'],
      date: map['date'],
      time: map['time'],
      followupDate: map['followup_date'],
      phone: map['phone'],
      duration:
          map['duration'] != null ? int.parse("${map['duration']}") : null,
      callType: map['call_type'],
      purpose: map['purpose'],
      remarks: map['remarks'],
      behavior: map["behavior"],
    );
  }

  // String toJson() => json.encode(toMap());

  factory CallLogEntity.fromJson(String source) =>
      CallLogEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant CallLogEntity other) {
    if (identical(this, other)) return true;
    return callBy == other.callBy &&
        callTo == other.callTo &&
        date == other.date &&
        time == other.time &&
        followupDate == other.followupDate &&
        phone == other.phone &&
        duration == other.duration &&
        callType == other.callType &&
        purpose == other.purpose &&
        remarks == other.remarks &&
        behavior == other.behavior;
  }

  @override
  int get hashCode {
    return callBy.hashCode ^
        callTo.hashCode ^
        date.hashCode ^
        time.hashCode ^
        followupDate.hashCode ^
        phone.hashCode ^
        duration.hashCode ^
        callType.hashCode ^
        purpose.hashCode ^
        remarks.hashCode ^
        behavior.hashCode;
  }
}
