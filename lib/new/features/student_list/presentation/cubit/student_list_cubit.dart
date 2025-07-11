import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_class_list_usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_section_list_of_class_usecase.dart';
import 'package:all_star_learning/new/features/student_list/domain/usecase/get_all_student_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'student_list_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  StudentListCubit({
    required this.getStudentListUsecase,
    required this.getClassListUsecase,
    required this.getClassSectionListUsecase,
  }) : super(StudentListState.initial()) {
    getClassList();
  }

  final GetStudentListUsecase getStudentListUsecase;
  final GetClassListUsecase getClassListUsecase;
  final GetClassSectionListUsecase getClassSectionListUsecase;

  Future<void> getClassList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    bool all = false,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await getClassListUsecase(
      all,
    );

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(isLoading: false));
      },
      (classList) {
        emit(state.copyWith(
          isLoading: false,
          classList: classList,
        ));
        onSuccess?.call();
      },
    );
  }

  Future<void> getStudentList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int classId,
    required int sectionId,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await getStudentListUsecase(
      StudentListParams(
        classId: classId,
        sectionId: sectionId,
      ),
    );

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(isLoading: false));
      },
      (studentList) {
        emit(state.copyWith(
          isLoading: false,
          studentList: studentList,
        ));
        onSuccess?.call();
      },
    );
  }

  Future<void> getClassSectionList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int classId,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await getClassSectionListUsecase(
      classId,
    );

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(isLoading: false));
      },
      (section) {
        emit(state.copyWith(
          isLoading: false,
          sectionList: section,
          selectedSectionId: () => section.isNotEmpty ? section.first.id : null,
        ));
        if(section.isNotEmpty) {
          getStudentList(
            classId: classId,
            sectionId: section.first.id ?? 0,
          );
        }
      },
    );
  }

  void setSelectedClassId(int? classId) {
    emit(state.copyWith(selectedClassId: () => classId));
  }

  void setSelectedSectionId(int? sectionId) {
    emit(state.copyWith(selectedSectionId: () => sectionId));
  }

  void initial() {
    emit(
      StudentListState(
        studentList: [],
        selectedClassId: null,
        selectedSectionId: null,
        classList: state.classList,
        isLoading: false,
        isSuccess: false,
        sectionList: state.sectionList,
      ),
    );
  }
}
