import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/student_list/data/models/class_model.dart';
import 'package:all_star_learning/new/features/student_list/data/models/section_model.dart';
import 'package:all_star_learning/new/features/student_list/data/models/student_model.dart';

import 'package:dartz/dartz.dart';

import '../data_source/remote/student_list_remote_data_source.dart';
import '../../domain/repository/student_list_repository.dart';

class StudentListRepositoryImpl implements IStudentListRepository {
  final StudentListRemoteDataSource remoteDataSource;

  StudentListRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<StudentModel>>> getStudents({
    int? classId,
    int? sectionId,
  }) async {
    return remoteDataSource.getStudents(classId: classId, sectionId: sectionId);
  }

  @override
  Future<Either<AppErrorHandler, List<ClassModel>>> getClassList(
      {bool all = false}) async {
    return remoteDataSource.getClassList(
      all: all,
    );
  }

  @override
  Future<Either<AppErrorHandler, List<SectionModel>>> getSectionList({
    required int classId,
  }) async {
    return remoteDataSource.getSectionList(classId: classId);
  }
}
