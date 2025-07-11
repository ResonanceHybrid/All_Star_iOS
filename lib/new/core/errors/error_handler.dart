

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppErrorHandler {
  final String message;
  final String? code;
  final String? data;
  final bool? status;
  AppErrorHandler({
    required this.message,
    this.code,
    this.data,
    this.status,
  });

  AppErrorHandler copyWith({
    String? message,
    String? code,
    String? data,
    bool? status,
  }) {
    return AppErrorHandler(
      message: message ?? this.message,
      code: code ?? this.code,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'AppErrorHandler(message: $message, code: $code, data: $data, status: $status)';
  }
}
