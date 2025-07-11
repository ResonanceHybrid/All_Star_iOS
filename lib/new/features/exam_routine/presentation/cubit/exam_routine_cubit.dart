import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/entities/exam_entity.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/usecase/get_exam_list_usecase.dart';
import 'package:all_star_learning/new/features/exam_routine/domain/usecase/get_exam_routine_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'exam_routine_state.dart';

class ExamRoutineCubit extends Cubit<ExamRoutineState> {
  ExamRoutineCubit({
    required this.getExamRoutineUseCase,
    required this.getExamListUseCase,
  }) : super(
          ExamRoutineState.initial(),
        ) {
    getExamList();
  }

  final GetExamRoutineUsecase getExamRoutineUseCase;
  final GetExamListUsecase getExamListUseCase;

  Future<void> getExamRoutine({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int examId,
    required int classId,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: () => null,
      examRoutineEntity: () => null,
    ));

    final result = await getExamRoutineUseCase(GetExamRoutineParams(
      examId: examId,
      classId: classId,
    ));

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(
          isLoading: false,
          error: () => error,
        ));
      },
      (examRoutineEntity) {
        emit(
          state.copyWith(
            error: () => null,
            isLoading: false,
            isSuccess: true,
            examRoutineEntity: () => examRoutineEntity,
          ),
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> getExamList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    int? classId,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: () => null,
    ));

    final result = await getExamListUseCase(classId);

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(
          isLoading: false,
          error: () => error,
        ));
      },
      (examList) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            examEntityList: () => examList,
            selectedExam: () => examList.isNotEmpty ? examList.first : null,
            error: () => null,
          ),
        );
        if (examList.isNotEmpty) {
          selectExam(selectedExam: examList.first);
          getExamRoutine(
            examId: examList.first.id ?? 0,
            classId: classId ?? 0,
          );
        } else {
          emit(state.copyWith(
            isLoading: false,
            examRoutineEntity: () => null,
          ));
        }
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void selectExam({
    ExamEntity? selectedExam,
  }) {
    emit(state.copyWith(selectedExam: () => selectedExam));
  }

  void clear() {
    emit(ExamRoutineState.initial());
  }

  void selectClass({required String classId}) {
    emit(state.copyWith(selectedClass: () => classId));
  }

  Future<void> getClasses({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    bool isAll = false,
  }) async {
    try {
      ApiMethods.getClasses(
        isAll: isAll,
      ).then((response) {
        if (response is SuccessResponse) {
          emit(state.copyWith(
            classList: response.data,
          ));
        } else {
          onError?.call(response.message!);
        }
      });
    } catch (e) {
      onError?.call(e.toString());
    }
  }
}
