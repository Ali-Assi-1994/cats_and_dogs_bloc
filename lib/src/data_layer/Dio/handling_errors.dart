import 'dart:io';

import 'package:dio/dio.dart';

enum NetworkException {
  requestCancelled,
  unauthorisedRequest,
  badRequest,
  notFound,
  methodNotAllowed,
  notAcceptable,
  requestTimeout,
  sendTimeout,
  conflict,
  internalServerError,
  notImplemented,
  serviceUnavailable,
  noInternetConnection,
  formatException,
  unableToProcess,
  defaultError,
  unexpectedError,
}

class NetworkExceptions {
  final NetworkException networkException;
  final String? error;

  NetworkExceptions(this.networkException, {this.error});

  factory NetworkExceptions.requestCancelled() => NetworkExceptions(NetworkException.requestCancelled);

  factory NetworkExceptions.unauthorisedRequest() => NetworkExceptions(NetworkException.unauthorisedRequest);

  factory NetworkExceptions.badRequest() => NetworkExceptions(NetworkException.badRequest);

  factory NetworkExceptions.notFound(String error) => NetworkExceptions(NetworkException.notFound, error: error);

  factory NetworkExceptions.methodNotAllowed() => NetworkExceptions(NetworkException.methodNotAllowed);

  factory NetworkExceptions.notAcceptable() => NetworkExceptions(NetworkException.notAcceptable);

  factory NetworkExceptions.requestTimeout() => NetworkExceptions(NetworkException.requestTimeout);

  factory NetworkExceptions.sendTimeout() => NetworkExceptions(NetworkException.sendTimeout);

  factory NetworkExceptions.conflict() => NetworkExceptions(NetworkException.conflict);

  factory NetworkExceptions.internalServerError() => NetworkExceptions(NetworkException.internalServerError);

  factory NetworkExceptions.notImplemented() => NetworkExceptions(NetworkException.notImplemented);

  factory NetworkExceptions.serviceUnavailable() => NetworkExceptions(NetworkException.serviceUnavailable);

  factory NetworkExceptions.noInternetConnection() => NetworkExceptions(NetworkException.noInternetConnection);

  factory NetworkExceptions.formatException() => NetworkExceptions(NetworkException.formatException);

  factory NetworkExceptions.unableToProcess() => NetworkExceptions(NetworkException.unableToProcess);

  factory NetworkExceptions.unexpectedError() => NetworkExceptions(NetworkException.unexpectedError);

  factory NetworkExceptions.defaultError(String error) => NetworkExceptions(NetworkException.defaultError, error: error);

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = NetworkExceptions.requestTimeout();
              break;

            case DioErrorType.receiveTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound("Not found");
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;

            case DioErrorType.badCertificate:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;

            case DioErrorType.connectionError:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.unknown:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(error) {
    NetworkExceptions networkException = NetworkExceptions.getDioException(error);
    return _getMessage(networkException);
  }

  static String _getMessage(NetworkExceptions networkException) {
    var errorMessage = "";
    switch (networkException.networkException) {
      case NetworkException.notImplemented:
        errorMessage = "Not Implemented";
        break;
      case NetworkException.requestCancelled:
        errorMessage = "Request Cancelled";
        break;
      case NetworkException.internalServerError:
        errorMessage = "Internal Server Error";
        break;
      case NetworkException.notFound:
        errorMessage = networkException.error ?? 'error';
        break;
      case NetworkException.serviceUnavailable:
        errorMessage = "Service unavailable";
        break;
      case NetworkException.methodNotAllowed:
        errorMessage = "Method Allowed";
        break;
      case NetworkException.badRequest:
        errorMessage = "Bad request";
        break;
      case NetworkException.unauthorisedRequest:
        errorMessage = "Unauthorised request";
        break;
      case NetworkException.unexpectedError:
        errorMessage = "Unexpected error occurred";
        break;
      case NetworkException.requestTimeout:
        errorMessage = "Connection request timeout";
        break;
      case NetworkException.noInternetConnection:
        errorMessage = "No internet connection";
        break;
      case NetworkException.conflict:
        errorMessage = "Error due to a conflict";
        break;
      case NetworkException.sendTimeout:
        errorMessage = "Send timeout in connection with API server";
        break;
      case NetworkException.unableToProcess:
        errorMessage = "Unable to process the data";
        break;

      case NetworkException.formatException:
        errorMessage = "Unexpected error occurred";
        break;

      case NetworkException.notAcceptable:
        errorMessage = "Not acceptable";
        break;
      case NetworkException.defaultError:
        errorMessage = networkException.error ?? 'error';
        break;
    }
    return errorMessage;
  }
}
