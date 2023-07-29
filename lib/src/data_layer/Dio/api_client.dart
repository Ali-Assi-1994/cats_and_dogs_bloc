import 'dart:async';

import 'package:dio/dio.dart';

import 'api.dart';

class ApiClient {
  final String baseUrl;
  final String apiKey;

  ApiClient({
    required this.baseUrl,
    required this.apiKey,
  }) {
    initDio();
  }

  late Dio _dio;

  void initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) {
        return status == null ? false : status < 500;
      },
      headers: {
        Headers.acceptHeader: "application/json",
        'x-api-key': apiKey,
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(ApiInterceptors());
  }

  Future<ApiResult> post({
    required String url,
    var data,
    StreamController<double>? uploadingStream,
  }) async {
    try {
      final response = await _dio.post(url, data: data, onSendProgress: (rcv, total) {
        if (uploadingStream != null) {
          uploadingStream.sink.add((rcv / total));
        }
      });
      if (response.data['code'] == 200) {
        return ApiResult.successFromJson(response.data);
      } else {
        if (response.data['code'] == 400 || response.data['code'] == 401 || response.data['code'] == 402) {}
        return ApiResult.failureFromJson(response.data);
      }
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<ApiResult> get({required String url, Options? options, Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters, cancelToken: cancelToken).timeout(const Duration(seconds: 15));
      if (response.data != null) {
        return ApiResult.successFromJson({'data': response.data});
      } else {
        return ApiResult.failureFromJson(response.data);
      }
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
