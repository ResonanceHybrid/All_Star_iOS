import 'package:all_star_learning/new/features/complain_box/domain/entities/complain_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/entities/role_user_entity.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/create_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/create_reply_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/delete_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/delete_reply_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_all_complain_box_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_role_list_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_role_user_list_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/get_single_complain_usecase.dart';
import 'package:all_star_learning/new/features/complain_box/domain/usecase/update_complain_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complain_box_state.dart';

class ComplainBoxCubit extends Cubit<ComplainBoxState> {
  ComplainBoxCubit({
    required this.getAllComplainsUsecase,
    required this.getSingleComplainsUsecase,
    required this.createComplainUsecase,
    required this.updateComplainUsecase,
    required this.getRoleListUsecase,
    required this.getRoleUserListUsecase,
    required this.deleteComplainUsecase,
    required this.deleteReplyUsecase,
    required this.createReplyUsecase,
  }) : super(ComplainBoxState.initial()) {
    getAllComplains();
    getRoleList();
  }

  final GetAllComplainsUsecase getAllComplainsUsecase;
  final GetSingleComplainsUsecase getSingleComplainsUsecase;
  final CreateComplainsUsecase createComplainUsecase;
  final UpdateComplainsUsecase updateComplainUsecase;
  final GetRoleListUsecase getRoleListUsecase;
  final GetRoleUserListUsecase getRoleUserListUsecase;
  final DeleteComplainUsecase deleteComplainUsecase;
  final DeleteReplyUsecase deleteReplyUsecase;
  final CreateReplyUsecase createReplyUsecase;

  Future<void> getRoleList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getRoleListUsecase.call(null);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (roleList) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            roleList: roleList,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> getRoleUserList({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int roleId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getRoleUserListUsecase.call(roleId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (roleUsersList) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            roleUsersList: roleUsersList,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> getAllComplains({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getAllComplainsUsecase.call(null);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (complains) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            complains: complains,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> getSingleComplain({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int complainId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getSingleComplainsUsecase.call(complainId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (complain) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            selectedComplain: complain,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> updateComplain({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int complainId,
    int? roleId,
    String? title,
    String? description,
    List<int>? complainToIds,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await updateComplainUsecase.call(
      UpdateComplainUsecaseParams(
        complainId: complainId,
        roleId: roleId,
        title: title,
        description: description,
        complainToIds: complainToIds,
      ),
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (complain) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            selectedComplain: complain,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> createComplain({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int roleId,
    required String title,
    required String description,
    required List<int> complainToIds,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await createComplainUsecase.call(
      CreateComplainUsecaseParams(
        roleId: roleId,
        title: title,
        description: description,
        complainToIds: complainToIds,
      ),
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (complain) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            selectedComplain: complain,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> deleteComplain({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int complainId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await deleteComplainUsecase(complainId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (isDeleted) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> createReply({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int complainId,
    required String description,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await createReplyUsecase.call(
      CreateReplyParams(
        complainId: complainId,
        description: description,
      ),
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (reply) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> deleteReply({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required int complainId,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await deleteReplyUsecase(complainId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
          ),
        );
        onError?.call(error.message);
      },
      (isDeleted) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
          ),
        );
        onSuccess?.call();
      },
    );
  }

  void clearSelectedComplain() {
    emit(
      state.copyWith(
        selectedComplain: null,
      ),
    );
  }

  void selectRole(int? value) {
    final List<int> allRoleIds = state.roleList.map((e) => e.id ?? 0).toList();
    if (allRoleIds.contains(value)) {
      final role = state.roleList.firstWhere(
        (element) => element.id == value,
      );
      emit(
        state.copyWith(
          selectedRole: () => role,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedRole: () => null,
        ),
      );
    }
  }

  void selectToleUsers(int? value) {
    final List<int> allRoleUserIds =
        state.roleUsersList.map((e) => e.id ?? 0).toList();

    if (allRoleUserIds.contains(value)) {
      final roleUser = state.roleUsersList.firstWhere(
        (element) => element.id == value,
      );

      final List<RoleUserEntity> selectedRoleUsers =
          List.from(state.selectedRoleUser);

      // Check if the roleUser is already in the selectedRoleUsers list
      if (!selectedRoleUsers.any((user) => user.id == roleUser.id)) {
        final newSelectedRoleUserList = selectedRoleUsers..add(roleUser);

        emit(
          state.copyWith(
            selectedRoleUser: newSelectedRoleUserList,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          selectedRoleUser: [],
        ),
      );
    }
  }

  void removeSelectedRoleUser(int? value) {
    final roleUser = state.selectedRoleUser.firstWhere(
      (element) => element.id == value,
    );

    final List<RoleUserEntity> selectedRoleUsers =
        List.from(state.selectedRoleUser);

    final newSelectedRoleUserList = selectedRoleUsers..remove(roleUser);

    emit(
      state.copyWith(
        selectedRoleUser: newSelectedRoleUserList,
      ),
    );
  }

  void clearSelectedRoleUsers() {
    final newState = ComplainBoxState(
      isLoading: false,
      isSuccess: false,
      complains: state.complains,
      selectedComplain: null,
      roleList: state.roleList,
      roleUsersList: [],
      selectedRole: null,
      selectedRoleUser: [],
    );
    emit(newState);
  }

  void selectComplain(ComplainEntity complain) {
    emit(
      state.copyWith(
        selectedComplain: complain,
      ),
    );
  }
}
