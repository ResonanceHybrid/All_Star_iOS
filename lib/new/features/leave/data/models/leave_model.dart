import 'package:all_star_learning/new/features/leave/domain/entities/leave_entity.dart';

class LeaveModel extends LeaveEntity {
  LeaveModel({
    super.id,
    super.roleId,
    super.user,
    super.subject,
    super.dateFrom,
    super.dateTo,
    super.reason,
    super.isApproved,
    super.createdAt,
    super.show,
    super.edit,
    super.delete,
  });
  @override
  String toString() {
    return 'LeaveModel {"id": $id, "roleId": $roleId, "user": $user, "subject": $subject, "dateFrom": $dateFrom, "dateTo": $dateTo, "reason": $reason, "isApproved": $isApproved, "createdAt": $createdAt, "show": $show, "edit": $edit, "delete": $delete, }';
  }

  @override
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

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
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

  static List<LeaveModel> fromListMap(List<dynamic> data) {
    return data.map((e) => LeaveModel.fromMap(e)).toList();
  }
}
