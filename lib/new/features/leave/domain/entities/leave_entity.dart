import 'dart:convert';

class LeaveEntity {
  final int? id;
  final String? roleId;
  final String? user;
  final String? subject;
  final String? dateFrom;
  final String? dateTo;
  final String? reason;
  final int? isApproved;
  final String? createdAt;
  final bool? show;
  final bool? edit;
  final bool? delete;
  LeaveEntity({
    this.id,
    this.roleId,
    this.user,
    this.subject,
    this.dateFrom,
    this.dateTo,
    this.reason,
    this.isApproved,
    this.createdAt,
    this.show,
    this.edit,
    this.delete,
  });
  LeaveEntity copyWith({
    int? id,
    String? roleId,
    String? user,
    String? subject,
    String? dateFrom,
    String? dateTo,
    String? reason,
    int? isApproved,
    String? createdAt,
    bool? show,
    bool? edit,
    bool? delete,
  }) {
    return LeaveEntity(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      user: user ?? this.user,
      subject: subject ?? this.subject,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      reason: reason ?? this.reason,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      show: show ?? this.show,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
    );
  }

  @override
  String toString() {
    return 'LeaveEntity {"id": $id, "roleId": $roleId, "user": $user, "subject": $subject, "dateFrom": $dateFrom, "dateTo": $dateTo, "reason": $reason, "isApproved": $isApproved, "createdAt": $createdAt, "show": $show, "edit": $edit, "delete": $delete, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_id': roleId,
      'user': user,
      'subject': subject,
      'date_from': dateFrom,
      'date_to': dateTo,
      'reason': reason,
      'is_approved': isApproved,
      'created_at': createdAt,
      'show': show,
      'edit': edit,
      'delete': delete,
    };
  }

  factory LeaveEntity.fromMap(Map<String, dynamic> map) {
    return LeaveEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      roleId: map['role_id'],
      user: map['user'],
      subject: map['subject'],
      dateFrom: map['date_from'],
      dateTo: map['date_to'],
      reason: map['reason'],
      isApproved: map['is_approved'] != null
          ? int.parse("${map['is_approved']}")
          : null,
      createdAt: map['created_at'],
      show: map['show'],
      edit: map['edit'],
      delete: map['delete'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveEntity.fromJson(String source) =>
      LeaveEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant LeaveEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        roleId == other.roleId &&
        user == other.user &&
        subject == other.subject &&
        dateFrom == other.dateFrom &&
        dateTo == other.dateTo &&
        reason == other.reason &&
        isApproved == other.isApproved &&
        createdAt == other.createdAt &&
        show == other.show &&
        edit == other.edit &&
        delete == other.delete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roleId.hashCode ^
        user.hashCode ^
        subject.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        reason.hashCode ^
        isApproved.hashCode ^
        createdAt.hashCode ^
        show.hashCode ^
        edit.hashCode ^
        delete.hashCode;
  }
}
