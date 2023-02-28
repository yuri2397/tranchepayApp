import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class PaymentProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> wave(
          {required double amount,
          required String phone,
          required String commandeId}) async =>
      _client.post('/payments/wave',
          data: {'amount': amount, 'phone': phone, 'commande_id': commandeId});

  Future<dio.Response> om(
      {required double amount,
        required String phone,
        required String commandeId}) async =>
      _client.post('/payments/om',
          data: {'amount': amount, 'phone': phone, 'commande_id': commandeId});

  Future<dio.Response> free(
      {required double amount,
        required String phone,
        required String commandeId}) async =>
      _client.post('/payments/free',
          data: {'amount': amount, 'phone': phone, 'commande_id': commandeId});

  Future<dio.Response> checkPayment(String paddingId) async =>
      _client.get('/shared/check-padding/$paddingId');

}
