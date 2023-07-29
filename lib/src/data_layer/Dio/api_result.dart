enum ApiResultType { success, failure }

class ApiResult<T> {
  ApiResultType type;
  T? data;
  String? message;
  bool? error;

  ApiResult({required this.type, this.data, this.message, this.error});

  factory ApiResult.successFromJson(Map<String, dynamic> json) => ApiResult.fromJson(json, ApiResultType.success);

  factory ApiResult.failure(String errorMsg) => ApiResult(type: ApiResultType.failure, message: errorMsg, error: true);

  factory ApiResult.failureFromJson(Map<String, dynamic> json) => ApiResult.fromJson(json, ApiResultType.failure);

  factory ApiResult.fromJson(Map<String, dynamic> json, ApiResultType resultType) => ApiResult(
        type: resultType,
        data: json["data"],
        // error: json["error"],
        // message: json["message"],
      );

  String get errorMessage => message ?? 'error';

  @override
  String toString() {
    return 'ApiResult :{ type: $type,  message: $message,${error != null ? 'error: $error' : ''} , ${data == null ? '' : 'data'} }';
  }
}
