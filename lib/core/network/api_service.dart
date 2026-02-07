import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_flavors_boilerplate/app/common/extensions/type_extensions.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/core/network/api_library.dart';
import 'package:flutter_flavors_boilerplate/utils/logger/app_logger.dart';
import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';

final class ApiService implements ApiLibrary {
  // app config
  static final AppConfig _appConfig = AppDependencyManager.appConfig;

  // dio client
  final Dio _dioClient = Dio();

  ApiService() {
    // config base URL
    _dioClient.options
      ..baseUrl = _appConfig.apiBaseUrl
      ..connectTimeout = const Duration(seconds: 5);
    // add interceptors
    _dioClient.interceptors.add(_interceptors);
    logSuccess(
      'ApiService created with Base Url - ${_dioClient.options.baseUrl}',
      tag: 'ApiService constructor',
    );
  }

  // Retry Interceptor Machenism
  // void _addRetryInterceptor() {}

  // public function to handle exceptions
  static void handleExeption(Exception exception) {
    if ((exception is DioException).not()) {
      SnackbarManager.showError(exception.toString());
    }
  }

  // interceptors
  InterceptorsWrapper get _interceptors => InterceptorsWrapper(
    onRequest: _onRequest,
    onResponse: _onResponse,
    onError: _onError,
  );

  // request interceptor
  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // process requests

    // fetch token from local db
    // String? token = await AuthService.authToken;

    // append with rest to headers
    options.headers = {...options.headers, 'Authorization': 'Bearer #token'};

    // log info
    logInfo('API Request - ${options.method} ${options.uri}', timestamp: true);
    logInfo('headers - ${options.headers}');
    logInfo('body - ${options.data}');
    logInfo('params - ${options.queryParameters}');

    handler.next(options);
  }

  // response interceptor
  void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // process response
    logSuccess(
      'API Request Success - ${response.requestOptions.path} ${json.encode(response.data)}',
      timestamp: true,
    );

    handler.next(response);
  }

  // error interceptor
  void _onError(DioException exception, ErrorInterceptorHandler handler) async {
    // handle exceptions
    logError(
      'API Request Exception - ${exception.response?.statusCode} ${exception.error}',
      timestamp: true,
    );
    logError(
      'API Request Exception - response ${exception.response.toString()}',
    );
    logError('API Request Exception - ${exception.message}', stackTrace: true);

    // handle socket exception
    if (exception.type == DioExceptionType.connectionError) {
      SnackbarManager.showError(
        'No Internet Connection',
        autoDismissable: false,
      );
    }

    // handle connection timeout
    if (exception.type == DioExceptionType.connectionTimeout) {
      SnackbarManager.showError(
        'Looks like the server is taking to long to respond, please try again in sometime.',
        autoDismissable: false,
      );
    }

    // handle all kinds of dio exceptions
    // if response has a message then show it
    if (exception.response != null) {
      Map<String, dynamic> response;
      if (exception.response?.statusCode != null &&
          exception.response!.statusCode != 801) {
        try {
          response = json.decode(exception.response.toString());
          SnackbarManager.showError(
            response['message'] ?? exception.toString(),
          );
        } catch (e) {
          SnackbarManager.showError(e.toString());
        }
      }
    }

    // Unathorized callback
    if (exception.response?.statusCode != null &&
        exception.response!.statusCode == 401) {
      // auto logout user
      // remove user info from local storage
      // navigate to login
    }

    handler.next(exception);
  }

  @override
  Future<bool> login() async {
    return false;
  }
}
