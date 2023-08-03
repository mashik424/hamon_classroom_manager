import 'package:dio/dio.dart';

class AppException implements Exception {
  final dynamic error;

  AppException([this.error]);

  @override
  String toString() {
    if (error == null) return "Exception";
    if (error is String) {
      return error as String;
    }
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return "Request to API server was cancelled";
            case DioExceptionType.connectionTimeout:
              return "Connection timeout with API server";

            case DioExceptionType.unknown:
              return "Connection to API server failed due to internet connection";

            case DioExceptionType.receiveTimeout:
              return "Receive timeout in connection with API server";

            case DioExceptionType.badResponse:
              switch (error.response.statusCode) {
                case 404:
                case 500:
                case 503:
                  return error.response.statusMessage;

                default:
                  if (error?.response?.data['message'] != null) {
                    return error.response.data['message'].toString();
                  } else {
                    return "Failed to load data - status code: ${error.response.statusCode}";
                  }
              }
            case DioExceptionType.sendTimeout:
              return "Send timeout with server";
          }
        } else {
          return "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        return e.toString();
      }
    } else {
      return error.toString();
    }
    return error.toString();
  }
}
