import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Custom exception class to handle Dio errors.
class DioExceptions implements Exception {
  late String message;

  // Constructor to create exceptions from Dio errors.
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
            dioError.message,
            dioError.response!.data["message"]);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  // Helper method to handle specific HTTP status codes.
  String _handleError(
      int? statusCode, dynamic error, dynamic mess, dynamic resMessage) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        if (kDebugMode) {
          print("401"); // Print for debugging purposes in debug mode.
        }
        return 'Unauthorized';
      case 403:
        if (resMessage == "Access denied") {
          // Handle refresh access token scenario.
        } else {
          // Handle other 403 errors (forbidden).
        }
        return 'Forbidden';
      case 404:
        return "Not Found";
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
