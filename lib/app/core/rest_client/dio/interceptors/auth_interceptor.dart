import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['auth_required'] == true) {
      options.queryParameters.addAll({"key": apiKey});
    }
    handler.next(options);
  }
}
