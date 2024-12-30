import 'dart:io';

import 'package:apiapp/error_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
abstract class NetworkException with _$NetworkException {
  const factory NetworkException.unexpectedError() = UnexpectedError;
  const factory NetworkException.requestCancelled() = RequestCancelled;
  const factory NetworkException.unableToProcess() = UnableToProcess;
  const factory NetworkException.requestTimeout() = RequestTimeout;
  const factory NetworkException.noInternetConnection() = NoInternetConnection;
  const factory NetworkException.sendTimeout() = SendTimeout;
  const factory NetworkException.formatException() = FormatException;

  const factory NetworkException.notFound(String error) = NotFound;
  const factory NetworkException.unauthorizedRequest(String error) =
      UnauthorizedRequest;
  const factory NetworkException.unprocessableEntity(String error) =
      UnprocessableEntity;
  const factory NetworkException.internalServerError() = InternalServerError;
  const factory NetworkException.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkException.defaultError(String error) = defaultError;

  static NetworkException handleResponse(response) {
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        String error = response.data['message'];
        return NetworkException.unauthorizedRequest(error);
      case 404:
        String error = response.data['message'];
        return NetworkException.notFound(error);
      case 422:
        List<ErrorModel> errorsFromJson = (response.data as List).map((error) {
          return ErrorModel.fromJson(error as Map<String, dynamic>);
        }).toList();

        List<String> errors = errorsFromJson.map(
          (error) {
            return '${error.field} ${error.message}';
          },
        ).toList();
        return NetworkException.unprocessableEntity(errors.join(' - '));
      case 500:
        return const NetworkException.internalServerError();
      case 503:
        return const NetworkException.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkException.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkException getDioException(error) {
    if (error is Exception) {
      try {
        NetworkException networkException;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkException = const NetworkException.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkException = const NetworkException.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkException = const NetworkException.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkException = const NetworkException.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkException =
                  NetworkException.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkException = const NetworkException.sendTimeout();
              break;
            default:
              networkException = const NetworkException.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkException = const NetworkException.noInternetConnection();
        } else {
          networkException = const NetworkException.unexpectedError();
        }
        return networkException;
      } on FormatException catch (_) {
        return const NetworkException.formatException();
      } catch (_) {
        return const NetworkException.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkException.unableToProcess();
      } else {
        return const NetworkException.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkException networkException) {
    var errorMessage = "";
    networkException.when(
      requestCancelled: () {
        errorMessage = "Request Cancelled";
      },
      internalServerError: () {
        errorMessage = "Internal Server Error";
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = "Service unavailable";
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = "Unexpected error occurred";
      },
      requestTimeout: () {
        errorMessage = "Connection request timeout";
      },
      noInternetConnection: () {
        errorMessage = "No internet connection";
      },
      sendTimeout: () {
        errorMessage = "Send timeout in connection with API server";
      },
      unableToProcess: () {
        errorMessage = "Unable to process the data";
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = "Unexpected error occurred";
      },
    );
    return errorMessage;
  }
}
