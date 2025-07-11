// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';

class ComplainBoxState {
  final bool isLoading;
  final bool isSuccess;

  final List<RoleUserEntity> roleList;
  final List<RoleUserEntity> roleUsersList;
  final RoleUserEntity? selectedRole;
  final List<RoleUserEntity> selectedRoleUser;

  final List<ComplainEntity> complains;
  final ComplainEntity? selectedComplain;
  ComplainBoxState({
    required this.isLoading,
    required this.isSuccess,
    required this.roleList,
    required this.roleUsersList,
    this.selectedRole,
    required this.selectedRoleUser,
    required this.complains,
    this.selectedComplain,
  });

  factory ComplainBoxState.initial() {
    return ComplainBoxState(
      isLoading: false,
      isSuccess: false,
      complains: <ComplainEntity>[],
      roleList: <RoleUserEntity>[],
      roleUsersList: <RoleUserEntity>[],
      selectedRoleUser: <RoleUserEntity>[],
    );
  }

  ComplainBoxState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<RoleUserEntity>? roleList,
    List<RoleUserEntity>? roleUsersList,
    ValueGetter<RoleUserEntity?>? selectedRole,
    List<RoleUserEntity>? selectedRoleUser,
    List<ComplainEntity>? complains,
    ComplainEntity? selectedComplain,
  }) {
    return ComplainBoxState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      roleList: roleList ?? this.roleList,
      roleUsersList: roleUsersList ?? this.roleUsersList,
      selectedRole: selectedRole != null ? selectedRole() : this.selectedRole,
      selectedRoleUser: selectedRoleUser ?? this.selectedRoleUser,
      complains: complains ?? this.complains,
      selectedComplain: selectedComplain ?? this.selectedComplain,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'roleList': roleList.map((x) => x.toMap()).toList(),
      'roleUsersList': roleUsersList.map((x) => x.toMap()).toList(),
      'selectedRole': selectedRole?.toMap(),
      'selectedRoleUser': selectedRoleUser.map((x) => x.toMap()).toList(),
      'complains': complains.map((x) => x.toMap()).toList(),
      'selectedComplain': selectedComplain?.toMap(),
    };
  }

  factory ComplainBoxState.fromMap(Map<String, dynamic> map) {
    return ComplainBoxState(
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      roleList: List<RoleUserEntity>.from(
        (map['roleList'] as List<int>).map<RoleUserEntity>(
          (x) => RoleUserEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      roleUsersList: List<RoleUserEntity>.from(
        (map['roleUsersList'] as List<int>).map<RoleUserEntity>(
          (x) => RoleUserEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      selectedRole: map['selectedRole'] != null
          ? RoleUserEntity.fromMap(map['selectedRole'] as Map<String, dynamic>)
          : null,
      selectedRoleUser: List<RoleUserEntity>.from(
        (map['selectedRoleUser'] as List<int>).map<RoleUserEntity>(
          (x) => RoleUserEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      complains: List<ComplainEntity>.from(
        (map['complains'] as List<int>).map<ComplainEntity>(
          (x) => ComplainEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      selectedComplain: map['selectedComplain'] != null
          ? ComplainEntity.fromMap(
              map['selectedComplain'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainBoxState.fromJson(String source) =>
      ComplainBoxState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ComplainBoxState(isLoading: $isLoading, isSuccess: $isSuccess, roleList: $roleList, roleUsersList: $roleUsersList, selectedRole: $selectedRole, selectedRoleUser: $selectedRoleUser, complains: $complains, selectedComplain: $selectedComplain)';
  }

  @override
  bool operator ==(covariant ComplainBoxState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.roleList, roleList) &&
        listEquals(other.roleUsersList, roleUsersList) &&
        other.selectedRole == selectedRole &&
        listEquals(other.selectedRoleUser, selectedRoleUser) &&
        listEquals(other.complains, complains) &&
        other.selectedComplain == selectedComplain;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        roleList.hashCode ^
        roleUsersList.hashCode ^
        selectedRole.hashCode ^
        selectedRoleUser.hashCode ^
        complains.hashCode ^
        selectedComplain.hashCode;
  }
}
