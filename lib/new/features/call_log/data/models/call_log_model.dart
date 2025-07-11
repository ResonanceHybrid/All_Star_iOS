import '../../domain/entities/call_log_entity.dart';

class CallLogModel extends CallLogEntity {
  CallLogModel({
    super.callBy,
    super.callTo,
    super.date,
    super.time,
    super.followupDate,
    super.phone,
    super.duration,
    super.callType,
    super.purpose,
    super.remarks,
    super.behavior,
  });
  // @override
  // String toString() {
  //   return 'CallLogModel {"callBy": $callBy, "callTo": $callTo, "date": $date, "time": $time, "followupDate": $followupDate, "phone": $phone, "duration": $duration, "callType": $callType, "purpose": $purpose, "remarks": $remarks, }';
  // }

  // @override
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

  factory CallLogModel.fromMap(Map<String, dynamic> map) {
    return CallLogModel(
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

  static List<CallLogModel> fromListMap(List<dynamic> data) {
    return data.map((e) => CallLogModel.fromMap(e)).toList();
  }
}
