import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class OrderProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> index({params}) async {
    return _client.get('/commandes', params: params);
  }
}
