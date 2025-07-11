import 'package:all_star_learning/new/features/call_log/domain/entities/call_log_entity.dart';
import 'package:all_star_learning/new/features/call_log/domain/usecase/get_all_call_log_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_log_state.dart';

class CallLogCubit extends Cubit<CallLogState> {
  CallLogCubit({
    required this.getAllCallLogsUsecase,
  }) : super(CallLogState.initial());

  final GetAllCallLogsUsecase getAllCallLogsUsecase;

  Future<void> getAllCallLogs({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await getAllCallLogsUsecase.call(null);

    result.fold(
      (error) {
        onError?.call(error.message);
        emit(state.copyWith(isLoading: false));
      },
      (callLogs) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          callLogs: callLogs,
        ));
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void setSelectedCallLog(CallLogEntity callLog) {
    emit(state.copyWith(selectedCallLog: () => callLog));
  }
}
