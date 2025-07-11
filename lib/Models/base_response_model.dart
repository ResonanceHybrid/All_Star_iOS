class BaseResponse<T> {
  late T? data;
  String? message;
  String? code;
  BaseResponse({this.message, this.data, this.code});
}

class SuccessResponse<T> extends BaseResponse {
  SuccessResponse({super.data, super.message});
}

class ErrorResponse extends BaseResponse {
  ErrorResponse({super.message, super.code});
}
