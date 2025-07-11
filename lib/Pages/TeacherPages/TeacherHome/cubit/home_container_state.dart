part of 'home_container_cubit.dart';

class HomeContainerState {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic>? userDetails;

  HomeContainerState({
    required this.isLoading,
    required this.isSuccess,
    this.userDetails,
  });

  factory HomeContainerState.initial() {
    return HomeContainerState(
      isLoading: false,
      isSuccess: false,
      userDetails: null,
    );
  }

  HomeContainerState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<Map<String, dynamic>?>? userDetails,
  }) {
    return HomeContainerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      userDetails: userDetails != null ? userDetails() : this.userDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeContainerState &&
      other.isLoading == isLoading &&
      other.isSuccess == isSuccess &&
      other.userDetails == userDetails;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
      isSuccess.hashCode ^
      userDetails.hashCode;
  }
}

