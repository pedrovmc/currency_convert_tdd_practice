import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/dio/interceptors/auth_interceptor.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_exception.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_response.dart';
import 'package:dio/dio.dart';

class DioRestClient implements RestClient {
  late Dio _dio;

  final BaseOptions _defaultBaseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  DioRestClient({BaseOptions? options}) {
    _dio = Dio(options ?? _defaultBaseOptions);
    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
      AuthInterceptor(),
    ]);
  }

  @override
  RestClient auth() {
    _defaultBaseOptions.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultBaseOptions.extra['auth_required'] = false;
    return this;
  }

  @override
  RestClient temporaryURL() {
    _defaultBaseOptions.extra['temporary'] = true;
    return this;
  }

  @override
  RestClient removeTemporaryURL() {
    _defaultBaseOptions.extra.remove('temporary');
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    data,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  RestClientResponse? _dioErrorResponseConverter(Response? response) {
    return RestClientResponse(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response response) {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}
