import '../../domain/entities/parent_details_entity.dart';
class ParentDetailsModel extends ParentDetailsEntity{
ParentDetailsModel({
    super.id,
    super.fatherName,
    super.fatherOccupation,
    super.fatherPhone,
    super.motherName,
    super.motherOccupation,
    super.motherPhone,
    super.parentAddress,
    super.guardianName,
    super.guardianOccupation,
    super.guardianPhone,
    super.guardianAddress,
    super.guardianEmail,
    super.createdAt,
    super.updatedAt,
  });
  @override
  String toString() {
    return 'ParentDetailsModel {"id": $id, "fatherName": $fatherName, "fatherOccupation": $fatherOccupation, "fatherPhone": $fatherPhone, "motherName": $motherName, "motherOccupation": $motherOccupation, "motherPhone": $motherPhone, "parentAddress": $parentAddress, "guardianName": $guardianName, "guardianOccupation": $guardianOccupation, "guardianPhone": $guardianPhone, "guardianAddress": $guardianAddress, "guardianEmail": $guardianEmail, "createdAt": $createdAt, "updatedAt": $updatedAt, }';
  }
  @override
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
  factory ParentDetailsModel.fromMap(Map<String, dynamic> map) {
    return ParentDetailsModel(
      id:map['id'] != null ? int.parse("${map['id']}") : null,
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
}

