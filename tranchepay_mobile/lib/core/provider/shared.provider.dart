import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class SharedProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> parteners({params}) async {
    return _client.get('/parteners', params: params);
  }
}
