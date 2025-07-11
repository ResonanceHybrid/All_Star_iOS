import 'dart:convert';
import 'parent_details_entity.dart';

class StudentEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? image;
  final String? role;
  final String? className;
  final String? sectionName;
  final String? admissionNumber;
  final ParentDetailsEntity? parentDetails;
  final String? deviceToken;
  final bool? firstTimeLogin;
  final bool? feePermission;
  StudentEntity({
    this.id,
    this.name,
    this.email,
    this.image,
    this.role,
    this.className,
    this.sectionName,
    this.admissionNumber,
    this.parentDetails,
    this.deviceToken,
    this.firstTimeLogin,
    this.feePermission,
  });
  StudentEntity copyWith({
    int? id,
    String? name,
    String? email,
    dynamic image,
    String? role,
    String? className,
    String? sectionName,
    String? admissionNumber,
    ParentDetailsEntity? parentDetails,
    dynamic deviceToken,
    bool? firstTimeLogin,
    bool? feePermission,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      role: role ?? this.role,
      className: className ?? this.className,
      sectionName: sectionName ?? this.sectionName,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      parentDetails: parentDetails ?? this.parentDetails,
      deviceToken: deviceToken ?? this.deviceToken,
      firstTimeLogin: firstTimeLogin ?? this.firstTimeLogin,
      feePermission: feePermission ?? this.feePermission,
    );
  }

  @override
  String toString() {
    return 'StudentEntity {"id": $id, "name": $name, "email": $email, "image": $image, "role": $role, "className": $className, "sectionName": $sectionName, "admissionNumber": $admissionNumber, "parentDetails": $parentDetails, "deviceToken": $deviceToken, "firstTimeLogin": $firstTimeLogin, "feePermission": $feePermission, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'role': role,
      'class_name': className,
      'section_name': sectionName,
      'admission_number': admissionNumber,
      'parent_details': parentDetails?.toMap(),
      'device_token': deviceToken,
      'first_time_login': firstTimeLogin,
      'fee_permission': feePermission,
    };
  }

  factory StudentEntity.fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      email: map['email'],
      image: map['image'],
      role: map['role'],
      className: map['class_name'],
      sectionName: map['section_name'],
      admissionNumber: map['admission_number'],
      parentDetails: map['parent_details'] != null
          ? ParentDetailsEntity.fromMap(map['parent_details'])
          : null,
      deviceToken: map['device_token'],
      firstTimeLogin: map['first_time_login'],
      feePermission: map['fee_permission'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentEntity.fromJson(String source) =>
      StudentEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant StudentEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        name == other.name &&
        email == other.email &&
        image == other.image &&
        role == other.role &&
        className == other.className &&
        sectionName == other.sectionName &&
        admissionNumber == other.admissionNumber &&
        parentDetails == other.parentDetails &&
        deviceToken == other.deviceToken &&
        firstTimeLogin == other.firstTimeLogin &&
        feePermission == other.feePermission;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        image.hashCode ^
        role.hashCode ^
        className.hashCode ^
        sectionName.hashCode ^
        admissionNumber.hashCode ^
        parentDetails.hashCode ^
        deviceToken.hashCode ^
        firstTimeLogin.hashCode ^
        feePermission.hashCode;
  }
}
