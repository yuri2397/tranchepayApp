import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tranchepay_mobile/app/models/boutique.model.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/commercant.model.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/app/services/vendor.service.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class RegisterController extends GetxController {
  final RxString username = ''.obs;
  final RxString password = ''.obs;
  final RxString passwordConfirm = ''.obs;
  final RxBool pinConfirm = false.obs;
  final RxBool loading = false.obs;
  final registerType = UserType.client.obs;
  final phoneNumber = ''.obs;
  final opt = ''.obs;
  final client = Client().obs;
  final vendor = Commercant().obs;
  final clientFormLoad = false.obs;
  final registerLoad = false.obs;
  final step = 0.obs;
  final clientFormKey = GlobalKey<FormState>();
  final comFormKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController(text: '+221 ');
  final TextEditingController pinController = TextEditingController();
  final TextEditingController pinConfirmController = TextEditingController();
  final TextEditingController verifyOtpPinController = TextEditingController();

  Future<void> validateClientForm() async {
    Get.focusScope?.unfocus();
    if (clientFormKey.currentState?.validate() == true) {
      Get.log("CLIENT DATA: ${client.value.toJson()}");
      phoneNumber.value =
          client.value.telephone!.replaceAll(" ", "").removeAllWhitespace;
      await sendOpt();
    }
  }

  Future<void> validateVendorForm() async {
    Get.focusScope?.unfocus();
    if (comFormKey.currentState?.validate() == true) {
      phoneNumber.value =
          vendor.value.telephone!.replaceAll(" ", "").removeAllWhitespace;
      sendOpt();
    }
  }

  Future<void> createVendor() async {
    Get.focusScope?.unfocus();
    if (comFormKey.currentState?.validate() == true) {
      phoneNumber.value =
          vendor.value.telephone!.replaceAll(" ", "").removeAllWhitespace;
      await sendOpt();
    }
  }

  sendOpt() async {
    Get.focusScope?.unfocus();
    loading.value = true;
    try {
      await Get.find<AuthService>().sendOpt(phoneNumber.value);
      await otpBottomSheet();
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
        Get.back();
        Get.toNamed(AppRoutes.pinPage);
      } else {
        verifyOtpPinController.clear();
      }
    } catch (e) {
      verifyOtpPinController.clear();
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
            Text("Vous avez reçu un message avec le code de confirmation sur le numéro ${client.value.telephone}")
                .marginOnly(bottom: 10),
            PinCodeTextField(
                controller: verifyOtpPinController,
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
                      Get.back();
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
      client.value.telephone =
          client.value.telephone?.replaceAll(" ", "").removeAllWhitespace;

      if (registerType.value == UserType.client) {
        final response = await Get.find<AuthService>()
            .registerClient(client.value, pinController.text);
        _registerSuccess(response);
      } else {
        printInfo(info: "REGISTER VENDOR");
        final response = await Get.find<AuthService>()
            .registerVendor(vendor.value, pinController.text);
        _registerSuccess(response);
      }
    } catch (e) {
      print("REGISTER : $e");
      rethrow;
    } finally {
      registerLoad.value = false;
    }
  }

  void _registerSuccess(response) {
    if (response != null) {
      QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          title: "Bienvenue sur TranchePay !",
          text:
              'Nous sommes ravis de vous avoir parmi nos utilisateurs. Notre application mobile vous permettra de gérer facilement vos paiements et vos transactions en toute sécurité.',
          confirmBtnText: "Merci!",
          confirmBtnColor: Color(primaryColor),
          confirmBtnTextStyle:
              TextStyle(color: Color(mainColor), fontFamily: 'Poppins'),
          onConfirmBtnTap: () {
            if (registerType.value == UserType.client) {
              Get.offAllNamed(AppRoutes.loginNumber);
            } else {
              Get.offAllNamed(AppRoutes.addShop);
            }
          });
    }
  }
}
