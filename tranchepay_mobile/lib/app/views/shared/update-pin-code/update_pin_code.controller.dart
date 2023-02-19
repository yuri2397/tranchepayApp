import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class UpdatePinCondeController extends GetxController {
  final pin = ''.obs;
  final newPin = ''.obs;
  final confPin = ''.obs;
  final loading = false.obs;
  final error = false.obs;
  final _authService = Get.find<AuthService>();
  final steps = 0.obs;
  final stepsText = [
    "Entrez votre code secret",
    "Définier un nouveau code secret",
    "Confirmer votre nouveau code secret"
  ].obs;
  final passwordController = TextEditingController(text: '').obs;
  final newPasswordController = TextEditingController(text: '').obs;
  final confPasswordController = TextEditingController(text: '').obs;

  Future<void> updatePin() async {
    loading.value = true;
    error.value = false;
    try {
      var response = await _authService.updatePassword(pin.value, newPin.value);
      if (response != null && response == true) {
        Ui.successMessage(message: 'Votre code pin a été modifié');
        Get.back();
      }
    } catch (e) {
      print('[UpdatePinCondeController]: (updatePin) => $e');
    } finally {
      loading.value = false;
    }
  }

  clearAllField() {
    passwordController.close();
  }

  @override
  void onClose() {
    passwordController.close();
    newPasswordController.close();
    confPasswordController.close();
    super.onClose();
  }
}
