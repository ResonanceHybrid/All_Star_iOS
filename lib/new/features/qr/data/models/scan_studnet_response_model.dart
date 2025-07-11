import '../../domain/entities/scan_studnet_response_entity.dart';
import 'class_model.dart';
import 'section_model.dart';
import 'current_class_model.dart';

class ScanStudentResponseModel extends ScanStudentResponseEntity {
  ScanStudentResponseModel({
    super.id,
    super.parentId,
    super.name,
    super.newOldKey,
    super.regNo,
    super.genderId,
    super.dobAd,
    super.dobBs,
    super.email,
    super.studentPhone,
    super.height,
    super.weight,
    super.isDisable,
    super.userId,
    super.religionId,
    super.caste,
    super.bloodGroupId,
    super.photo,
    super.permanentAddress,
    super.temporaryAddress,
    super.prevSchoolDetail,
    super.nationalId,
    super.localId,
    super.bankAccNo,
    super.bankName,
    super.guardianRelation,
    super.createdAt,
    super.updatedAt,
    super.classEntity,
    super.section,
    super.rollNo,
    super.admissionDate,
    super.currentClass,
  });
  @override
  String toString() {
    return 'ScanStudnetResponseModel {"id": $id, "parentId": $parentId, "name": $name, "newOldKey": $newOldKey, "regNo": $regNo, "genderId": $genderId, "dobAd": $dobAd, "dobBs": $dobBs, "email": $email, "studentPhone": $studentPhone, "height": $height, "weight": $weight, "isDisable": $isDisable, "userId": $userId, "religionId": $religionId, "caste": $caste, "bloodGroupId": $bloodGroupId, "photo": $photo, "permanentAddress": $permanentAddress, "temporaryAddress": $temporaryAddress, "prevSchoolDetail": $prevSchoolDetail, "nationalId": $nationalId, "localId": $localId, "bankAccNo": $bankAccNo, "bankName": $bankName, "guardianRelation": $guardianRelation, "createdAt": $createdAt, "updatedAt": $updatedAt, "class": $classEntity, "section": $section, "rollNo": $rollNo, "admissionDate": $admissionDate, "currentClass": $currentClass, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'new_old_key': newOldKey,
      'reg_no': regNo,
      'gender_id': genderId,
      'dob_ad': dobAd,
      'dob_bs': dobBs,
      'email': email,
      'student_phone': studentPhone,
      'height': height,
      'weight': weight,
      'is_disable': isDisable,
      'user_id': userId,
      'religion_id': religionId,
      'caste': caste,
      'blood_group_id': bloodGroupId,
      'photo': photo,
      'permanent_address': permanentAddress,
      'temporary_address': temporaryAddress,
      'prev_school_detail': prevSchoolDetail,
      'national_id': nationalId,
      'local_id': localId,
      'bank_acc_no': bankAccNo,
      'bank_name': bankName,
      'guardian_relation': guardianRelation,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'class': classEntity?.toMap(),
      'section': section?.toMap(),
      'roll_no': rollNo,
      'admission_date': admissionDate,
      'current_class': currentClass?.toMap(),
    };
  }

  factory ScanStudentResponseModel.fromMap(Map<String, dynamic> map) {
    return ScanStudentResponseModel(
      id: map['id'] != null ? int.parse("${map['id']}") : null,
      parentId:
          map['parent_id'] != null ? int.parse("${map['parent_id']}") : null,
      name: map['name'],
      newOldKey: map['new_old_key'],
      regNo: map['reg_no'],
      genderId:
          map['gender_id'] != null ? int.parse("${map['gender_id']}") : null,
      dobAd: map['dob_ad'],
      dobBs: map['dob_bs'],
      email: map['email'],
      studentPhone: map['student_phone'],
      height: map['height'],
      weight: map['weight'],
      isDisable:
          map['is_disable'] != null ? int.parse("${map['is_disable']}") : null,
      userId: map['user_id'] != null ? int.parse("${map['user_id']}") : null,
      religionId: map['religion_id'],
      caste: map['caste'],
      bloodGroupId: map['blood_group_id'],
      photo: map['photo'],
      permanentAddress: map['permanent_address'],
      temporaryAddress: map['temporary_address'],
      prevSchoolDetail: map['prev_school_detail'],
      nationalId: map['national_id'],
      localId: map['local_id'],
      bankAccNo: map['bank_acc_no'],
      bankName: map['bank_name'],
      guardianRelation: map['guardian_relation'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      classEntity:
          map['class'] != null ? ClassModel.fromMap(map['class']) : null,
      section:
          map['section'] != null ? SectionModel.fromMap(map['section']) : null,
      rollNo: map['roll_no'] != null ? int.parse("${map['roll_no']}") : null,
      admissionDate: map['admission_date'],
      currentClass: map['current_class'] != null
          ? CurrentClassModel.fromMap(map['current_class'])
          : null,
    );
  }
}
