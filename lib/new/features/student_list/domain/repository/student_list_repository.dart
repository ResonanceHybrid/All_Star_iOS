import 'package:all_star_learning/new/core/errors/error_handler.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/class_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/section_entity.dart';
import 'package:all_star_learning/new/features/student_list/domain/entities/student_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IStudentListRepository {
  Future<Either<AppErrorHandler, List<StudentEntity>>> getStudents({
    int? classId,
    int? sectionId,
  });
  Future<Either<AppErrorHandler, List<ClassEntity>>> getClassList({
    bool all = false,
  });
  Future<Either<AppErrorHandler, List<SectionEntity>>> getSectionList({
    required int classId,
  });
}
