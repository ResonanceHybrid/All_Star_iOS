import 'dart:convert';

class ParentDetailsEntity {
  final int? id;
  final String? fatherName;
  final String? fatherOccupation;
  final String? fatherPhone;
  final String? motherName;
  final String? motherOccupation;
  final String? motherPhone;
  final String? parentAddress;
  final String? guardianName;
  final String? guardianOccupation;
  final String? guardianPhone;
  final String? guardianAddress;
  final String? guardianEmail;
  final String? createdAt;
  final String? updatedAt;
  ParentDetailsEntity({
    this.id,
    this.fatherName,
    this.fatherOccupation,
    this.fatherPhone,
    this.motherName,
    this.motherOccupation,
    this.motherPhone,
    this.parentAddress,
    this.guardianName,
    this.guardianOccupation,
    this.guardianPhone,
    this.guardianAddress,
    this.guardianEmail,
    this.createdAt,
    this.updatedAt,
  });
  ParentDetailsEntity copyWith({
    int? id,
    String? fatherName,
    String? fatherOccupation,
    String? fatherPhone,
    String? motherName,
    String? motherOccupation,
    String? motherPhone,
    String? parentAddress,
    String? guardianName,
    String? guardianOccupation,
    String? guardianPhone,
    String? guardianAddress,
    String? guardianEmail,
    String? createdAt,
    String? updatedAt,
  }) {
    return ParentDetailsEntity(
      id: id ?? this.id,
      fatherName: fatherName ?? this.fatherName,
      fatherOccupation: fatherOccupation ?? this.fatherOccupation,
      fatherPhone: fatherPhone ?? this.fatherPhone,
      motherName: motherName ?? this.motherName,
      motherOccupation: motherOccupation ?? this.motherOccupation,
      motherPhone: motherPhone ?? this.motherPhone,
      parentAddress: parentAddress ?? this.parentAddress,
      guardianName: guardianName ?? this.guardianName,
      guardianOccupation: guardianOccupation ?? this.guardianOccupation,
      guardianPhone: guardianPhone ?? this.guardianPhone,
      guardianAddress: guardianAddress ?? this.guardianAddress,
      guardianEmail: guardianEmail ?? this.guardianEmail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ParentDetailsEntity {"id": $id, "fatherName": $fatherName, "fatherOccupation": $fatherOccupation, "fatherPhone": $fatherPhone, "motherName": $motherName, "motherOccupation": $motherOccupation, "motherPhone": $motherPhone, "parentAddress": $parentAddress, "guardianName": $guardianName, "guardianOccupation": $guardianOccupation, "guardianPhone": $guardianPhone, "guardianAddress": $guardianAddress, "guardianEmail": $guardianEmail, "createdAt": $createdAt, "updatedAt": $updatedAt, }';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'father_name': fatherName,
      'father_occupation': fatherOccupation,
      'father_phone': fatherPhone,
      'mother_name': motherName,
      'mother_occupation': motherOccupation,
      'mother_phone': motherPhone,
      'parent_address': parentAddress,
      'guardian_name': guardianName,
      'guardian_occupation': guardianOccupation,
      'guardian_phone': guardianPhone,
      'guardian_address': guardianAddress,
      'guardian_email': guardianEmail,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ParentDetailsEntity.fromMap(Map<String, String> map) {
    return ParentDetailsEntity(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      fatherName: map['father_name'],
      fatherOccupation: map['father_occupation'],
      fatherPhone: map['father_phone'],
      motherName: map['mother_name'],
      motherOccupation: map['mother_occupation'],
      motherPhone: map['mother_phone'],
      parentAddress: map['parent_address'],
      guardianName: map['guardian_name'],
      guardianOccupation: map['guardian_occupation'],
      guardianPhone: map['guardian_phone'],
      guardianAddress: map['guardian_address'],
      guardianEmail: map['guardian_email'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParentDetailsEntity.fromJson(String source) =>
      ParentDetailsEntity.fromMap(json.decode(source) as Map<String, String>);

  @override
  bool operator ==(covariant ParentDetailsEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        fatherName == other.fatherName &&
        fatherOccupation == other.fatherOccupation &&
        fatherPhone == other.fatherPhone &&
        motherName == other.motherName &&
        motherOccupation == other.motherOccupation &&
        motherPhone == other.motherPhone &&
        parentAddress == other.parentAddress &&
        guardianName == other.guardianName &&
        guardianOccupation == other.guardianOccupation &&
        guardianPhone == other.guardianPhone &&
        guardianAddress == other.guardianAddress &&
        guardianEmail == other.guardianEmail &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fatherName.hashCode ^
        fatherOccupation.hashCode ^
        fatherPhone.hashCode ^
        motherName.hashCode ^
        motherOccupation.hashCode ^
        motherPhone.hashCode ^
        parentAddress.hashCode ^
        guardianName.hashCode ^
        guardianOccupation.hashCode ^
        guardianPhone.hashCode ^
        guardianAddress.hashCode ^
        guardianEmail.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
