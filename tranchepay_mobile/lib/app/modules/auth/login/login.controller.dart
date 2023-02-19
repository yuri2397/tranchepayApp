import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';
import 'package:tranchepay_mobile/app/models/user.model.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class LoginController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final loading = false.obs;
  final _clientService = Get.find<ClientService>();
  final _authSerice = Get.find<AuthService>();
  final inputController = TextEditingController();
  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
      mask: "+221 ## ### ## ##", type: MaskAutoCompletionType.eager);
  final localStorage = Get.find<LocalStorageService>();
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> login() async {
    Get.focusScope?.unfocus();
    loading.value = true;
    try {
      final response = await _authSerice.login(
          username: username.value, password: password.value);

      if (response != null) {
        Get.log(response.toJson().toString());
        localStorage.setToken(response.token!.accessToken!);
        localStorage.setUser(response.user!.toJson());
        localStorage.setUserType(response.user!.modelType);

        localStorage.setIsLogged(true);

        if (localStorage.getUserType() == 'client') {
          Get.log("GO TO CLIENT MODULE");
          Get.offAllNamed(AppRoutes.clientModule);
        } else {
          // Get.toNamed(AppRoutes.vendor);
        }
      }
    } catch (e) {
      Get.log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> checkPhoneNumber() async {
    try {
      loading.value = true;
      User? response = await _authSerice.userByPhoneNumber(
          inputController.text.removeAllWhitespace.substring(1));

      if (response != null) {
        username.value = inputController.text.removeAllWhitespace.substring(1);
        Get.toNamed(AppRoutes.login);
      } else {
        Ui.errorMessage(message: 'Veuillez créer un nouveau compte');
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
