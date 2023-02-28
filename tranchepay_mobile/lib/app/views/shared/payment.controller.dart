import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tranchepay_mobile/app/models/om_payment_response.model.dart';
import 'package:tranchepay_mobile/app/models/wave_payment.model.dart';
import 'package:tranchepay_mobile/app/services/payement.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/button.widget.dart';

class PaymentController extends GetxController {
  final loading = false.obs;
  final paymentService = Get.find<PaymentService>();
  final amount = TextEditingController();
  final phone = TextEditingController();
  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
      mask: "+221 ## ### ## ##", type: MaskAutoCompletionType.eager);
  Timer? periodicTimer;

  final panelHeightOpen = (500.0).obs;
  final panelHeightClosed = (0.0).obs;
  final initFabHeight = (120.0).obs;
  final fabHeight = (120.0).obs;

  final panelController = PanelController();

  final Rx<String> _selected = 'wave'.obs;

  Rx<String> get selected => _selected;

  change(String changed) {
    _selected.value = changed;
    Get.back();
  }

  void paymentTypeChange(String type) {
    selected.value = type;
    selected.refresh();
  }

  Future<dynamic> makePayment({required String commandeId}) async {
    Get.focusScope?.unfocus();
    var amount = this.amount.value.text;
    var phone = this.phone.value.text.removeAllWhitespace.replaceAll(" ", "");
    loading.value = true;
    loading.refresh();
    Get.log("AMOUNT $amount, PHONE: phone, TYPE: ${selected.value}");
    try {
      switch (selected.value) {
        case 'wave':
          WavePaymentResponse? wave = await paymentService.wave(
              amount: double.tryParse(amount) ?? 0,
              phone: phone,
              commandeId: commandeId);

          if (wave != null) {
            //launchUrl(Uri.parse(wave.data.waveLaunchUrl));
            await _waitConfirmation(title: wave.message, code: "wave", paddingId: wave.padding);
          } else {
            Ui.errorMessage(message: "Une erreur s'est produite");
          }
          break;
        case 'free':
          break;
        case 'om':
          OmPaymentResponse? om = await paymentService.om(
              amount: double.tryParse(amount) ?? 0,
              phone: phone,
              commandeId: commandeId);

          if (om != null) {
            await _waitConfirmation(title: "Veuillez confirmer votre paiement.", code: "om", paddingId: om.padding);
          }
          break;
      }
    } catch (e) {
      print("errorioj $e");
    } finally {
      loading.value = false;
    }
  }


  Future<void> _waitConfirmation({
    required String title,
    required String code,
    required paddingId
  }) async {
    executePeriodically(paddingId);
    Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      cancel: PrimaryButton(
          elevation: 0,
          onPressed: () {
            stopExecution();
            Get.back();
          },
          child: const Text(
            "Annuler le paiement",
            style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
          )),
      titlePadding: const EdgeInsets.only(top: 30, bottom: 20),
      content: Container(
          color: Colors.white,
          width: Get.width,
          height: 200,
          child: Column(
            children: [
              CircularProgressIndicator(
                color: Color(mainColor),
                strokeWidth: 2,
              ).marginOnly(bottom: 20),
              Image.asset(
                "assets/icons/$code.png",
                width: 60,
                height: 60,
              )

            ],
          )),
    );
  }

  void executePeriodically(String padding) {
    periodicTimer = Timer.periodic(const Duration(seconds: 7), (timer) async {
        if((await paymentService.checkPayment(padding))){
          stopExecution();
          Get.back();
          Get.back();
          Ui.successMessage(message: "Paiement valider avec succes", title: "Notification", );
        }
    });
  }

  void stopExecution() {
    periodicTimer?.cancel(); // Annule l'exécution périodique
  }
}
