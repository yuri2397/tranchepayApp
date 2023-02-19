import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/app/models/wave_payment.model.dart';
import 'package:tranchepay_mobile/app/services/payement.service.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class PaymentController extends GetxController {
  final loading = false.obs;
  final paymentService = Get.find<PaymentService>();
  final amount = TextEditingController();
  final phone = TextEditingController();
  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
      mask: "+221 ## ### ## ##", type: MaskAutoCompletionType.eager);
  String? commandeId;

  final Rx<String> _selected = 'wave'.obs;
  Rx<String> get selected => _selected;

  void onInit() {
    commandeId = Get.parameters['commande_id'];
    super.onInit();
  }

  change(String changed) {
    _selected.value = changed;
    Get.back();
  }

  void paymentTypeChange(String type) {
    selected.value = type;
    selected.refresh();
  }

  Future<dynamic> makePayment() async {
    Get.focusScope?.unfocus();
    var amount = this.amount.value.text;
    var phone = this.phone.value.text.removeAllWhitespace.replaceAll(" ", "");
    loading.value = true;
    loading.refresh();
    Get.log("AMOUNT ${amount}, PHONE: ${phone}, TYPE: ${selected.value}");
    try {
      switch (selected.value) {
        case 'wave':
          WavePaymentResponse? wave = await paymentService.wave(
              amount: double.tryParse(amount)!,
              phone: phone,
              commandeId: commandeId!);
          if (wave != null) {
          } else {
            Ui.errorMessage(message: "Une erreur s'est produite");
          }
          break;
        case 'free':
          break;
        case 'om':
          break;
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
