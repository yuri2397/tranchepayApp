import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/login_response.model.dart';
import 'package:tranchepay_mobile/app/models/user.model.dart';
import 'package:tranchepay_mobile/core/provider/auth.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:dio/dio.dart' as dio;

class AuthService extends GetxService {
  static final _provider = AuthProvider();
  final user = User(
      id: "-1",
      username: "",
      emailVerifyAt: DateTime.now(),
      etat: 0,
      model: "",
      modelType: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      permissions: []).obs;
  Future<AuthService> init() async {
    return this;
  }

  Future<LoginResponse?> login(
      {required String username, required String password}) async {
    try {
      final response = await _provider.login(
          username: username.removeAllWhitespace, password: password);
      if (response.statusCode == 200) {
        var data = LoginResponse.fromJson(response.data);
        user.value = data.user!;
        user.refresh();
        return data;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserNotificationToken(String token) async {
    try {
      await _provider.updateUserNotificationToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    // await _client.httpClient.delete(
    //   Routes.logout,
    //   options: _client.optionsNetwork,
    // );
    // await _client._box.remove('token');
  }

  Future<dynamic> sendOpt(String phoneNumber) async {
    try {
      final response = await _provider.sendOtp(phoneNumber);
      return response.data;
    } catch (e) {
      Ui.errorMessage(title: "Erreur", message: "Erreur de connexion");
      rethrow;
    }
  }

  Future<dynamic> verifyOpt(String phoneNumber, String otpCode) async {
    try {
      print("phoneNumber: $phoneNumber, otpCode: $otpCode");
      final response = await _provider.verifyOtp(data: {
        'phone_number': phoneNumber,
        'otp_code': otpCode,
      });
      print(response);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 422) {
        Ui.errorMessage(title: "Erreur", message: "Code OTP invalide");
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Client?> registerClient(Client client, String password) async {
    try {
      final response = await _provider.registerClient(
          data: client.toJson()..addAll({'password': password}));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else if (response.statusCode == 422) {
        Ui.errorMessage(title: "Erreur", message: "Code OTP invalide");
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User?> userByPhoneNumber(String username) async {
    try {
      Get.log("PHONE NUMBER: $username");
      dio.Response response = await _provider.userByPhoneNumber(username);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> updatePassword(String password, String newPassword) async {
    try {
      var response = await _provider.updatePassword(password, newPassword);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      Ui.errorMessage(message: 'Une erreur s\'est produite', title: 'Erreur');
      print('[AuthService] : (updatePassword) => $e');
      return null;
    }
  }
}
