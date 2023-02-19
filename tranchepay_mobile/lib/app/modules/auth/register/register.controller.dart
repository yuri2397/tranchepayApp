import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class RegisterController extends GetxController {
  final RxString username = '781879981'.obs;
  final RxString password = ''.obs;
  final RxString passwordConfirm = ''.obs;
  final RxBool pinConfirm = false.obs;
  final RxBool loading = false.obs;
  final registerType = UserType.client.obs;
  final phoneNumber = ''.obs;
  final opt = ''.obs;
  final client = Client().obs;
  final clientFormLoad = false.obs;
  final registerLoad = false.obs;
  final step = 0.obs;

  final phoneNumberController = TextEditingController(text: '+221 ');
  final TextEditingController pinController = TextEditingController();
  final TextEditingController pinConfirmController = TextEditingController();

  Future<void> validateClientForm() async {
    if (client.value.prenoms!.isNotEmpty && client.value.nom!.isNotEmpty) {
      clientFormLoad.value = true;
      phoneNumber.value = client.value.telephone!.replaceAll(' ', '');
      await sendOpt();
      Get.log("OPEN BOTTOM SHEET");
      otpBottomSheet();
      clientFormLoad.value = false;
    }
  }

  sendOpt() async {
    Get.focusScope?.unfocus();
    loading.value = true;
    print(client);
    try {
      final response = await Get.find<AuthService>().sendOpt(phoneNumber.value);
      print(response);
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  verifyOpt() async {
    Get.focusScope?.unfocus();
    loading.value = true;
    try {
      var response =
          await Get.find<AuthService>().verifyOpt(phoneNumber.value, opt.value);
      if (response != null) {
        Get.toNamed(AppRoutes.pinPage);
      }
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  otpBottomSheet() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verification du numéro de téléphone",
                    style: Get.textTheme.headline2)
                .marginOnly(bottom: 8),
            Text("Vous recevrez un un SMS avec un code de confirmation sur le numéro ${phoneNumber.value}")
                .marginOnly(bottom: 10),
            PinCodeTextField(
                keyboardType: TextInputType.number,
                animationType: AnimationType.none,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.black,
                  activeColor: Color(mainColor),
                  inactiveColor: Color(neutralColor),
                  selectedColor: Color(mainColor),
                  borderWidth: 3,
                ),
                appContext: Get.context!,
                length: 5,
                onChanged: (value) {
                  opt.value = value;
                },
                onCompleted: (value) async {
                  opt.value = value;
                  await verifyOpt();
                }).marginOnly(bottom: 20),
            TextButton(
                    onPressed: () async {
                      await sendOpt();
                    },
                    child: Text("Renvoyer un nouveau code",
                        style: Get.textTheme.button))
                .marginOnly(bottom: 10),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 2,
      isDismissible: false,
    );
  }

  Future<void> register() async {
    registerLoad.value = true;
    try {
      if (registerType.value == UserType.client) {
        final response = await Get.find<AuthService>()
            .registerClient(client.value, pinController.text);
        if (response != null) {
          client.value = response;
          Get.find<LocalStorageService>().setIsLogged(true);
          Get.find<LocalStorageService>().setUserType('App\\Models\\Client');
          Get.find<LocalStorageService>().setClient(response.toJson());
          Get.offAllNamed(AppRoutes.clientProfile);
        }
      } else {}
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      registerLoad.value = false;
    }
  }
}
