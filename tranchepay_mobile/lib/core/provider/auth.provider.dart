import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class AuthProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> login(
          {required String username, required String password}) async =>
      _client.post('/auth/login',
          data: {'username': username, 'password': password});

  Future<dio.Response> sendOtp(String phoneNumber) async =>
      _client.post('/auth/otp/request', data: {'phone_number': phoneNumber});

  Future<dio.Response> verifyOtp({required Map<String, dynamic> data}) async =>
      _client.post('/auth/otp/verify', data: data);

  Future<dio.Response> registerClient(
          {required Map<String, dynamic> data}) async =>
      _client.post('/auth/register/client', data: data);

  Future<dio.Response> userByPhoneNumber(String username) async =>
      _client.get('/auth/check', params: {'username': username});

  Future<dio.Response> updatePassword(
          String password, String newPassword) async =>
      _client.put('/auth/update-password',
          data: {'password': password, 'new_password': newPassword});

  Future<dio.Response> updateUserNotificationToken(String token) =>
      _client.put('/auth/update-fcm-token', data: {'token': token});

  Future<dio.Response> registerVendor(
      {required Map<String, dynamic> data,}) async => _client.post('/auth/register/vendor', data: data);
}
