import '../../domain/entities/exam_routine_entity.dart';
import 'routine_model.dart';

class ExamRoutineModel extends ExamRoutineEntity {
  ExamRoutineModel({
    super.exam,
    super.routine,
  });
  @override
  String toString() {
    return 'ExamRoutineModel {"exam": $exam, "routine": $routine, }';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'exam': exam,
      'routine': routine?.map((e) => e.toMap()).toList(),
    };
  }

  factory ExamRoutineModel.fromMap(Map<String, dynamic> map) {
    return ExamRoutineModel(
      exam: map['exam'],
      routine: map['routine'] != null
          ? List<RoutineModel>.from(
              map['routine']?.map((x) => RoutineModel.fromMap(x)))
          : null,
    );
  }
}
