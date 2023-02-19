import 'dart:developer';

import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/ui.dart';

import 'base_client.dart';

class ApiClient extends GetxService with BaseApiClient {
  late dio.Dio httpClient;
  late dio.Options optionsNetwork;
  late dio.Options optionsCache;
  late GetStorage _box;

  ApiClient() {
    baseUrl = settingsService.setting.value.appApiUrl!;
    httpClient = createDio();
    _box = GetStorage();
    Get.log('TanelApiClient created');
    Get.log('baseUrl: $baseUrl');
  }

  Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 15000,
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  Future<ApiClient> init() async {
    if (foundation.kIsWeb || foundation.kDebugMode) {
      optionsNetwork = dio.Options();
      optionsCache = dio.Options();
    } else {
      optionsNetwork =
          buildCacheOptions(const Duration(days: 3), forceRefresh: true);
      optionsCache =
          buildCacheOptions(const Duration(minutes: 10), forceRefresh: false);
    }
    return this;
  }

  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      optionsCache = dio.Options();
    }
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      optionsCache = buildCacheOptions(duration, forceRefresh: false);
    }
  }

  Future<dio.Response> get(String url, {Map<String, dynamic>? params}) async {
    Uri uri = getApiBaseUri(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }
    return await httpClient.get(url, queryParameters: params);
  }

  Future<dio.Response> post(String url,
      {data, Map<String, dynamic>? params}) async {
    Uri uri = getApiBaseUri(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }
    Get.log(uri.toString());
    return await httpClient.postUri(uri, data: data, options: optionsNetwork);
  }

  Future<dio.Response> put(String url,
      {data, Map<String, dynamic>? params}) async {
    Uri uri = getApiBaseUri(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }
    return await httpClient.putUri(uri, data: data, options: optionsNetwork);
  }

  Future<dio.Response> delete(String url,
      {data, Map<String, dynamic>? params}) async {
    Uri uri = getApiBaseUri(url);
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }
    return await httpClient.deleteUri(uri, data: data, options: optionsNetwork);
  }
}

class AppInterceptors extends Interceptor {
  final Dio dioClient;

  AppInterceptors(this.dioClient);

  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
    var token = GetStorage().read('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    Get.log(
        "REQUEST[${options.method}] => PATH: ${options.path}, DATA: ${options.data}");
    return handler.next(options);
  }

  @override
  Future<void> onError(
      dio.DioError err, dio.ErrorInterceptorHandler handler) async {
    print("DATA ERR: ${err.response?.data}");
    if (err.response?.statusCode == 401 &&
        Get.currentRoute != AppRoutes.login) {
      await Get.find<AuthService>().logout();
      Get.offAndToNamed(AppRoutes.login);
    } else if (err.response?.statusCode == 422) {
      Ui.errorMessage(message: err.response?.data['message']);
    }
    handler.next(err);
  }
}
