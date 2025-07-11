import 'dart:convert';
import 'class_entity.dart';
import 'section_entity.dart';
import 'current_class_entity.dart';

class ScanStudentResponseEntity {
  final int? id;
  final int? parentId;
  final String? name;
  final String? newOldKey;
  final String? regNo;
  final int? genderId;
  final dynamic dobAd;
  final dynamic dobBs;
  final dynamic email;
  final dynamic studentPhone;
  final dynamic height;
  final dynamic weight;
  final int? isDisable;
  final int? userId;
  final dynamic religionId;
  final dynamic caste;
  final dynamic bloodGroupId;
  final dynamic photo;
  final dynamic permanentAddress;
  final dynamic temporaryAddress;
  final dynamic prevSchoolDetail;
  final dynamic nationalId;
  final dynamic localId;
  final dynamic bankAccNo;
  final dynamic bankName;
  final dynamic guardianRelation;
  final String? createdAt;
  final String? updatedAt;
  final ClassEntity? classEntity;
  final SectionEntity? section;
  final int? rollNo;
  final dynamic admissionDate;
  final CurrentClassEntity? currentClass;
  ScanStudentResponseEntity({
    this.id,
    this.parentId,
    this.name,
    this.newOldKey,
    this.regNo,
    this.genderId,
    this.dobAd,
    this.dobBs,
    this.email,
    this.studentPhone,
    this.height,
    this.weight,
    this.isDisable,
    this.userId,
    this.religionId,
    this.caste,
    this.bloodGroupId,
    this.photo,
    this.permanentAddress,
    this.temporaryAddress,
    this.prevSchoolDetail,
    this.nationalId,
    this.localId,
    this.bankAccNo,
    this.bankName,
    this.guardianRelation,
    this.createdAt,
    this.updatedAt,
    this.classEntity,
    this.section,
    this.rollNo,
    this.admissionDate,
    this.currentClass,
  });
  ScanStudentResponseEntity copyWith({
    int? id,
    int? parentId,
    String? name,
    String? newOldKey,
    String? regNo,
    int? genderId,
    dynamic dobAd,
    dynamic dobBs,
    dynamic email,
    dynamic studentPhone,
    dynamic height,
    dynamic weight,
    int? isDisable,
    int? userId,
    dynamic religionId,
    dynamic caste,
    dynamic bloodGroupId,
    dynamic photo,
    dynamic permanentAddress,
    dynamic temporaryAddress,
    dynamic prevSchoolDetail,
    dynamic nationalId,
    dynamic localId,
    dynamic bankAccNo,
    dynamic bankName,
    dynamic guardianRelation,
    String? createdAt,
    String? updatedAt,
    ClassEntity? classEntity,
    SectionEntity? section,
    int? rollNo,
    dynamic admissionDate,
    CurrentClassEntity? currentClass,
  }) {
    return ScanStudentResponseEntity(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      newOldKey: newOldKey ?? this.newOldKey,
      regNo: regNo ?? this.regNo,
      genderId: genderId ?? this.genderId,
      dobAd: dobAd ?? this.dobAd,
      dobBs: dobBs ?? this.dobBs,
      email: email ?? this.email,
      studentPhone: studentPhone ?? this.studentPhone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isDisable: isDisable ?? this.isDisable,
      userId: userId ?? this.userId,
      religionId: religionId ?? this.religionId,
      caste: caste ?? this.caste,
      bloodGroupId: bloodGroupId ?? this.bloodGroupId,
      photo: photo ?? this.photo,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      temporaryAddress: temporaryAddress ?? this.temporaryAddress,
      prevSchoolDetail: prevSchoolDetail ?? this.prevSchoolDetail,
      nationalId: nationalId ?? this.nationalId,
      localId: localId ?? this.localId,
      bankAccNo: bankAccNo ?? this.bankAccNo,
      bankName: bankName ?? this.bankName,
      guardianRelation: guardianRelation ?? this.guardianRelation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      classEntity: classEntity ?? this.classEntity,
      section: section ?? this.section,
      rollNo: rollNo ?? this.rollNo,
      admissionDate: admissionDate ?? this.admissionDate,
      currentClass: currentClass ?? this.currentClass,
    );
  }

  @override
  String toString() {
    return 'ScanStudnetResponseEntity {"id": $id, "parentId": $parentId, "name": $name, "newOldKey": $newOldKey, "regNo": $regNo, "genderId": $genderId, "dobAd": $dobAd, "dobBs": $dobBs, "email": $email, "studentPhone": $studentPhone, "height": $height, "weight": $weight, "isDisable": $isDisable, "userId": $userId, "religionId": $religionId, "caste": $caste, "bloodGroupId": $bloodGroupId, "photo": $photo, "permanentAddress": $permanentAddress, "temporaryAddress": $temporaryAddress, "prevSchoolDetail": $prevSchoolDetail, "nationalId": $nationalId, "localId": $localId, "bankAccNo": $bankAccNo, "bankName": $bankName, "guardianRelation": $guardianRelation, "createdAt": $createdAt, "updatedAt": $updatedAt, "classEntity": $classEntity, "section": $section, "rollNo": $rollNo, "admissionDate": $admissionDate, "currentClass": $currentClass, }';
  }

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

  factory ScanStudentResponseEntity.fromMap(Map<String, dynamic> map) {
    return ScanStudentResponseEntity(
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
          map['class'] != null ? ClassEntity.fromMap(map['class']) : null,
      section:
          map['section'] != null ? SectionEntity.fromMap(map['section']) : null,
      rollNo: map['roll_no'] != null ? int.parse("${map['roll_no']}") : null,
      admissionDate: map['admission_date'],
      currentClass: map['current_class'] != null
          ? CurrentClassEntity.fromMap(map['current_class'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanStudentResponseEntity.fromJson(String source) =>
      ScanStudentResponseEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ScanStudentResponseEntity other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        parentId == other.parentId &&
        name == other.name &&
        newOldKey == other.newOldKey &&
        regNo == other.regNo &&
        genderId == other.genderId &&
        dobAd == other.dobAd &&
        dobBs == other.dobBs &&
        email == other.email &&
        studentPhone == other.studentPhone &&
        height == other.height &&
        weight == other.weight &&
        isDisable == other.isDisable &&
        userId == other.userId &&
        religionId == other.religionId &&
        caste == other.caste &&
        bloodGroupId == other.bloodGroupId &&
        photo == other.photo &&
        permanentAddress == other.permanentAddress &&
        temporaryAddress == other.temporaryAddress &&
        prevSchoolDetail == other.prevSchoolDetail &&
        nationalId == other.nationalId &&
        localId == other.localId &&
        bankAccNo == other.bankAccNo &&
        bankName == other.bankName &&
        guardianRelation == other.guardianRelation &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        classEntity == other.classEntity &&
        section == other.section &&
        rollNo == other.rollNo &&
        admissionDate == other.admissionDate &&
        currentClass == other.currentClass;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        name.hashCode ^
        newOldKey.hashCode ^
        regNo.hashCode ^
        genderId.hashCode ^
        dobAd.hashCode ^
        dobBs.hashCode ^
        email.hashCode ^
        studentPhone.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        isDisable.hashCode ^
        userId.hashCode ^
        religionId.hashCode ^
        caste.hashCode ^
        bloodGroupId.hashCode ^
        photo.hashCode ^
        permanentAddress.hashCode ^
        temporaryAddress.hashCode ^
        prevSchoolDetail.hashCode ^
        nationalId.hashCode ^
        localId.hashCode ^
        bankAccNo.hashCode ^
        bankName.hashCode ^
        guardianRelation.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        classEntity.hashCode ^
        section.hashCode ^
        rollNo.hashCode ^
        admissionDate.hashCode ^
        currentClass.hashCode;
  }
}
