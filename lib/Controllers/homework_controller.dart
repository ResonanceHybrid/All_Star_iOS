import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/custom_methods.dart';

class TeacherAddHomeworkController extends GetxController {
  List<ClassModel> _classes = [];
  List<SectionModel> _sections = [];
  List<TeacherSubjectModel> _teacherSubjects = [];

  bool _isClassLoading = false;
  bool _isSectionLoading = false;
  bool _isSubjectLoading = false;

  bool get isClassLoadingValue => _isClassLoading;
  bool get isSectionLoadingValue => _isSectionLoading;
  bool get isSubjectLoadingValue => _isSubjectLoading;

  List<ClassModel> get classesValue => _classes;
  List<SectionModel> get sectionsValue => _sections;
  List<TeacherSubjectModel> get teacherSubjectsValue => _teacherSubjects;

  @override
  void onInit() {
    super.onInit();
    loadClasses();
  }

  refreshFunction() {
    _classes.clear();
    _sections.clear();
    _teacherSubjects.clear();
    loadClasses();
    CustomMethods().showSnackBar(Get.context!, "Successfully Refreshed", Colors.green);
  }

  loadClasses() async {
    _isClassLoading = true;
    BaseResponse response = await ApiMethods.getClasses();
    if (response is SuccessResponse) {
      _classes = response.data;
    } else {
      CustomMethods().showSnackBar(Get.context!, response.message!, Colors.red);
    }
    _isClassLoading = false;
    update();
  }

  loadSections(String classId) async {
    _isSectionLoading = true;
    BaseResponse response = await ApiMethods.getSections(classId);
    if (response is SuccessResponse) {
      _sections = response.data;
    } else {
      CustomMethods().showSnackBar(Get.context!, response.message!, Colors.red);
    }
    _isSectionLoading = false;
    update();
  }

  loadSubjectsWithId(String classId, String sectionId, {String? examId}) async {
    _isSubjectLoading = true;
    BaseResponse response = await ApiMethods.getSubjectsWithId(classId: classId, sectionId: sectionId, examId: examId ?? "");
    if (response is SuccessResponse) {
      _teacherSubjects = response.data;
    } else {
      CustomMethods().showSnackBar(Get.context!, response.message!, Colors.red);
    }
    _isSubjectLoading = false;
    update();
  }
}
