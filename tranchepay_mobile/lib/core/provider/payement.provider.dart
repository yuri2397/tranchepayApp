import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class PaymentProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> wave(
          {required double amount,
          required String phone,
          required String commandeId}) async =>
      _client.post('/auth/login',
          data: {'amount': amount, 'phone': phone, 'commande_id': commandeId});

  Future<dio.Response> om(String phoneNumber) async =>
      _client.post('/auth/otp/request', data: {'phone_number': phoneNumber});

  Future<dio.Response> free({required Map<String, dynamic> data}) async =>
      _client.post('/auth/otp/verify', data: data);
}
