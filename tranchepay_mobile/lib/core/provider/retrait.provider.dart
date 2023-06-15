import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class RetraitProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> index({Map<String, dynamic>? params}) async {
    return _client.get('/retraits', params: params);
  }
}
