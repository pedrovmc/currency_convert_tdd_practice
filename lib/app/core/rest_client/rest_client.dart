import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_response.dart';

enum HttpStatusCode {
  information,
  success,
  redirect,
  clientError,
  serverError;

  factory HttpStatusCode.fromCode(int code) {
    if (code < 100 || code > 599) {
      throw Exception("Invalid status code");
    }

    return HttpStatusCode.values.elementAt((code ~/ 100) - 1);
  }
}

abstract class RestClient {
  RestClient auth();

  RestClient unauth();

  RestClient removeTemporaryURL();

  RestClient temporaryURL();

  Future<RestClientResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestClientResponse<T>> request<T>(
    String path, {
    dynamic data,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
