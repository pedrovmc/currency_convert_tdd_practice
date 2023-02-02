import 'rest_client.dart';
import 'rest_client_response.dart';

class RestClientException implements Exception {
  String? path;
  String? message;
  int? statusCode;
  HttpStatusCode? codeType;
  dynamic error;
  RestClientResponse? response;
  dynamic requestData;
  Map<String, dynamic>? queryParameters;

  RestClientException({
    this.path,
    this.message,
    this.statusCode,
    required this.error,
    this.response,
    this.requestData,
    this.queryParameters,
  }) : codeType =
            statusCode != null ? HttpStatusCode.fromCode(statusCode) : null;

  @override
  String toString() {
    return 'RestClientException(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
