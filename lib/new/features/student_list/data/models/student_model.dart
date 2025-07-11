import '../../domain/entities/student_entity.dart';
import 'parent_details_model.dart';

class StudentModel extends StudentEntity {
  StudentModel({
    super.id,
    super.name,
    super.email,
    super.image,
    super.role,
    super.className,
    super.sectionName,
    super.admissionNumber,
    super.parentDetails,
    super.deviceToken,
    super.firstTimeLogin,
    super.feePermission,
  });
  @override
  String toString() {
    return 'StudentModel {"id": $id, "name": $name, "email": $email, "image": $image, "role": $role, "className": $className, "sectionName": $sectionName, "admissionNumber": $admissionNumber, "parentDetails": $parentDetails, "deviceToken": $deviceToken, "firstTimeLogin": $firstTimeLogin, "feePermission": $feePermission, }';
  }

  @override
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

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      name: map['name'],
      email: map['email'],
      image: map['image'],
      role: map['role'],
      className: map['class_name'],
      sectionName: map['section_name'],
      admissionNumber: map['admission_number'],
      parentDetails: map['parent_details'] != null
          ? ParentDetailsModel.fromMap(map['parent_details'])
          : null,
      deviceToken: map['device_token'],
      firstTimeLogin: map['first_time_login'],
      feePermission: map['fee_permission'],
    );
  }

  static List<StudentModel> fromListMap(List<dynamic> data) {
    return data.map((e) => StudentModel.fromMap(e)).toList();
  }
}
