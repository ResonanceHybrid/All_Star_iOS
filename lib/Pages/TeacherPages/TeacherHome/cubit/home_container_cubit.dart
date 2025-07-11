import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Utils/local_storage.dart';

part 'home_container_state.dart';

class HomeContainerCubit extends Cubit<HomeContainerState> {
  HomeContainerCubit() : super(HomeContainerState.initial()) {
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    emit(state.copyWith(
      isLoading: true,
      userDetails: () => null,
    ));
    var details = LocalStorageMethods.getUserDetails();
    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
      userDetails: () => details,
    ));
  }
}
