import 'dart:developer';

import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/di/teacher_container_di.dart';
import 'package:all_star_learning/new/core/networks/api/dio_http_service.dart';
import 'package:all_star_learning/new/features/call_log/di/call_log_di.dart';
import 'package:all_star_learning/new/features/complain_box/di/complain_box_di.dart';
import 'package:all_star_learning/new/features/exam_routine/di/exam_routine_di.dart';
import 'package:all_star_learning/new/features/leave/di/leave_di.dart';
import 'package:all_star_learning/new/features/qr/di/qr_di.dart';
import 'package:all_star_learning/new/features/student_list/di/student_list_di.dart';
import 'package:all_star_learning/new/features/videos/di/videos_di.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> setUpLocator() async {
  log('locator register', name: "location register");
  locator.registerLazySingleton(() => DioHttpService());
  QRDI().register();
  LeaveDI().register();
  StudentListDI().register();
  ComplainBoxDI().register();
  CallLogDI().register();
  VideoDI().register();
  ExamRoutineDI().register();
  HomeContainerDI().register();
}
