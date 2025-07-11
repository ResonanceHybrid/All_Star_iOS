import 'package:all_star_learning/new/features/leave/domain/usecase/create_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/delete_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/get_all_leave_usecase.dart';
import 'package:all_star_learning/new/features/leave/domain/usecase/update_leave_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  LeaveCubit({
    required this.getAllLeavesUsecase,
    required this.deleteLeaveUsecase,
    required this.createLeaveUsecase,
    required this.updateLeaveUsecase,
  }) : super(LeaveState.initial()) {
    getAllLeaves();
  }

  final GetAllLeavesUsecase getAllLeavesUsecase;
  final DeleteLeaveUsecase deleteLeaveUsecase;
  final CreateLeaveUsecase createLeaveUsecase;
  final UpdateLeaveUsecase updateLeaveUsecase;

  Future<void> getAllLeaves({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
      ),
    );
    final result = await getAllLeavesUsecase(null);
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
        onError?.call(error.message);
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          leaves: r,
        ));
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> deleteLeave({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int leaveId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
      ),
    );
    final result = await deleteLeaveUsecase(leaveId);
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
        onError?.call(error.message);
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          leaves: r,
        ));
        // getAllLeaves();
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> createLeave({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
      ),
    );

    final params = LeaveParams(
        subject: subject, reason: reason, fromDate: fromDate, toDate: toDate);
    final result = await createLeaveUsecase(params);
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
        onError?.call(error.message);
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));
        getAllLeaves();
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> updateLeave({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int leaveId,
    required String subject,
    required String reason,
    required String fromDate,
    required String toDate,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
      ),
    );

    final params = LeaveParams(
        leaveId: leaveId,
        subject: subject,
        reason: reason,
        fromDate: fromDate,
        toDate: toDate);
    final result = await updateLeaveUsecase(params);
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
        onError?.call(error.message);
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));
        getAllLeaves();
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void changeToDate({
    required String toDate,
  }) {
    emit(
      state.copyWith(
        toDate: toDate,
      ),
    );
  }

  void changeFromDate({
    required String fromDate,
  }) {
    emit(
      state.copyWith(
        fromDate: fromDate,
      ),
    );
  }
}
