import 'rest_client.dart';

class RestClientResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  HttpStatusCode? codeType;

  RestClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  }) : codeType =
            statusCode != null ? HttpStatusCode.fromCode(statusCode) : null;

  @override
  String toString() {
    return "Data: ${data.toString()}, statusCode: ${statusCode.toString()}, statusMessage: ${statusMessage.toString()}";
  }
}
