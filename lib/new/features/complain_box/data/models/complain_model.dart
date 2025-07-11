import 'dart:convert';

import 'package:all_star_learning/new/features/complain_box/data/models/complain_to_model.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/complain_entity.dart';
import 'replies_model.dart';

class ComplainModel extends ComplainEntity {
  ComplainModel({
    super.id,
    super.roleId,
    super.userIds,
    super.title,
    super.description,
    super.isApproved,
    super.isActive,
    super.complainBy,
    super.complainTo,
    super.createdAt,
    super.replies,
    super.show,
    super.edit,
    super.delete,
  });

  @override
  String toString() {
    return 'ComplainModel(id: $id, roleId: $roleId, userIds: $userIds, title: $title, description: $description, isApproved: $isApproved, isActive: $isActive, complainBy: $complainBy, complainTo: $complainTo, createdAt: $createdAt, replies: $replies, show: $show, edit: $edit, delete: $delete)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_id': roleId,
      'user_ids': userIds,
      'title': title,
      'description': description,
      'is_approved': isApproved,
      'is_active': isActive,
      'complain_by': complainBy,
      'complain_to': complainTo?.map((e) => e.toMap()).toList(),
      'created_at': createdAt,
      'replies': replies?.map((e) => e.toMap()).toList(),
      'show': show,
      'edit': edit,
      'delete': delete,
    };
  }

  factory ComplainModel.fromMap(Map<String, dynamic> map) {
    return ComplainModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      roleId: map['role_id'] != null ? int.parse("${map['role_id']}") : null,
      userIds: map['user_ids'],
      title: map['title'],
      description: map['description'],
      isApproved: map['is_approved'] != null
          ? int.parse("${map['is_approved']}")
          : null,
      isActive:
          map['is_active'] != null ? int.parse("${map['is_active']}") : null,
      complainBy: map['complain_by'],
      complainTo: ComplainToModel.fromListMap(map['complain_to']),
      createdAt: map['created_at'],
      replies: RepliesModel.fromListMap(map['replies']),
      show: map['show'] ?? false,
      edit: map['edit'] ?? false,
      delete: map['delete'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ComplainModel.fromJson(String source) =>
      ComplainModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ComplainModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roleId == roleId &&
        listEquals(other.userIds, userIds) &&
        other.title == title &&
        other.description == description &&
        other.isApproved == isApproved &&
        other.isActive == isActive &&
        other.complainBy == complainBy &&
        listEquals(other.complainTo, complainTo) &&
        other.createdAt == createdAt &&
        listEquals(other.replies, replies) &&
        other.show == show &&
        other.edit == edit &&
        other.delete == delete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roleId.hashCode ^
        userIds.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isApproved.hashCode ^
        isActive.hashCode ^
        complainBy.hashCode ^
        complainTo.hashCode ^
        createdAt.hashCode ^
        replies.hashCode ^
        show.hashCode ^
        edit.hashCode ^
        delete.hashCode;
  }

  static List<ComplainModel> fromListMap(List<dynamic> data) {
    return data.map((e) => ComplainModel.fromMap(e)).toList();
  }
}
