// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'complain_to_entity.dart';
import 'replies_entity.dart';

class ComplainEntity {
  final int? id;
  final int? roleId;
  final List<dynamic>? userIds;
  final String? title;
  final String? description;
  final int? isApproved;
  final int? isActive;
  final String? complainBy;
  final List<ComplainToEntity>? complainTo;
  final String? createdAt;
  final List<RepliesEntity>? replies;
  final bool? show;
  final bool? edit;
  final bool? delete;
  ComplainEntity({
    this.id,
    this.roleId,
    this.userIds,
    this.title,
    this.description,
    this.isApproved,
    this.isActive,
    this.complainBy,
    this.complainTo,
    this.createdAt,
    this.replies,
    this.show,
    this.edit,
    this.delete,
  });
  ComplainEntity copyWith({
    int? id,
    int? roleId,
    List<dynamic>? userIds,
    String? title,
    String? description,
    int? isApproved,
    int? isActive,
    String? complainBy,
    List<ComplainToEntity>? complainTo,
    String? createdAt,
    List<RepliesEntity>? replies,
    bool? show,
    bool? edit,
    bool? delete,
  }) {
    return ComplainEntity(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      userIds: userIds ?? this.userIds,
      title: title ?? this.title,
      description: description ?? this.description,
      isApproved: isApproved ?? this.isApproved,
      isActive: isActive ?? this.isActive,
      complainBy: complainBy ?? this.complainBy,
      complainTo: complainTo ?? this.complainTo,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
      show: show ?? this.show,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
    );
  }

  @override
  String toString() {
    return 'ComplainEntity(id: $id, roleId: $roleId, userIds: $userIds, title: $title, description: $description, isApproved: $isApproved, isActive: $isActive, complainBy: $complainBy, complainTo: $complainTo, createdAt: $createdAt, replies: $replies, show: $show, edit: $edit, delete: $delete)';
  }

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

  factory ComplainEntity.fromMap(Map<String, dynamic> map) {
    return ComplainEntity(
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
      complainTo:
          map['complain_to']?.map((e) => ComplainToEntity.fromMap(e))?.toList(),
      createdAt: map['created_at'],
      replies: map['replies']?.map((e) => RepliesEntity.fromMap(e))?.toList(),
      show: map['show'] ?? false,
      edit: map['edit'] ?? false,
      delete: map['delete'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainEntity.fromJson(String source) =>
      ComplainEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ComplainEntity other) {
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
}
