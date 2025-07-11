import 'package:all_star_learning/Models/Search/attendance_type_model.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/exam_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/custom_methods.dart';

class AppSearchController extends GetxController {
  final RxList<ExamModel> exams = <ExamModel>[].obs;
  final RxList<ClassModel> classes = <ClassModel>[].obs;
  final RxList<ClassModel> cASClasses = <ClassModel>[].obs;
  final RxList<SectionModel> sections = <SectionModel>[].obs;
  final RxList<MonthModel> months = <MonthModel>[].obs;
  final RxList<AttendanceTypeModel> attendanceTypes =
      <AttendanceTypeModel>[].obs;
  final RxList<QRAttendanceTypeEntity> attendanceTypesEntity =
      <QRAttendanceTypeEntity>[].obs;

  RxBool isSubjectLoading = false.obs;
  RxBool isSectionLoading = false.obs;

  final RxList<TeacherSubjectModel> teacherSubjects =
      <TeacherSubjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAttendanceType();
    // loadExams();
    loadClasses();
    // loadCASClasses();
    loadMonths();
  }

  refreshFunction() {
    attendanceTypes.clear();
    attendanceTypesEntity.clear();
    exams.clear();
    classes.clear();
    cASClasses.clear();
    sections.clear();
    months.clear();
    teacherSubjects.clear();
    loadAttendanceType();
    loadClasses();
    // loadExams();
    loadMonths();
    CustomMethods()
        .showSnackBar(Get.context!, "Successfully Refreshed", Colors.green);
  }

  loadExams(int classId) async {
    BaseResponse response = await ApiMethods.getExams(classId);
    if (response is SuccessResponse) {
      exams.value = response.data;
    } else {
      CustomMethods().showSnackBar(Get.context!, response.message!, Colors.red);
    }
  }

  loadAttendanceType() {
    attendanceTypes.clear();
    ApiMethods.getAttendanceType().then((response) {
      if (response is SuccessResponse) {
        attendanceTypes.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
    });
  }

  loadClasses() {
    sections.clear();
    ApiMethods.getClasses().then((response) {
      if (response is SuccessResponse) {
        classes.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
    });
  }

  loadCASClasses() {
    sections.clear();
    ApiMethods.getCASClasses().then((response) {
      if (response is SuccessResponse) {
        cASClasses.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
    });
  }

  loadSections(String classId) {
    isSectionLoading.value = true;

    ApiMethods.getSections(classId).then((response) {
      if (response is SuccessResponse) {
        sections.clear();
        sections.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
    });
    isSectionLoading.value = false;
  }

  loadSubjectsWithId(String classId, String sectionId, {String? examId}) {
    isSubjectLoading.value = true;
    teacherSubjects.clear();

    ApiMethods.getSubjectsWithId(
      classId: classId,
      sectionId: sectionId,
      examId: examId ?? "",
    ).then((response) {
      if (response is SuccessResponse) {
        teacherSubjects.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
      isSubjectLoading.value = false;
    });
  }

  loadMonths() {
    ApiMethods.getMonths().then((response) {
      if (response is SuccessResponse) {
        months.value = response.data;
      } else {
        CustomMethods()
            .showSnackBar(Get.context!, response.message!, Colors.red);
      }
    });
  }
}
