import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/register.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class TakePinConfirmPage extends GetView<RegisterController> {
  const TakePinConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(neutralColor),
          title: Text(
            "CONFIRMATION".toUpperCase(),
            style: Get.textTheme.headline2
                ?.merge(TextStyle(color: Color(mainColor))),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(mainColor)),
            onPressed: () => Get.back(),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.forgotPassword),
              child: SvgPicture.asset(
                "assets/icons/help.svg",
                width: 35,
                height: 35,
              ).marginOnly(right: 20),
            )
          ],
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/key_pin.svg",
                      width: 60, height: 60)
                  .marginOnly(bottom: 30),
              const Text(
                'Confirmez votre code PIN',
                style: TextStyle(fontSize: 15),
              ).marginOnly(bottom: 40),
              PinCodeTextField(
                controller: controller.pinConfirmController,
                appContext: context,
                length: 4,
                obscureText: true,
                autoUnfocus: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  inactiveFillColor: Color(neutralColor),
                  borderWidth: 3,
                  activeFillColor: Color(neutralColor),
                  selectedFillColor: Color(neutralColor),
                  selectedColor: Color(mainColor),
                  activeColor: Color(mainColor),
                  inactiveColor: Color(neutralColor),
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) async {
                  if (controller.pinController.text ==
                      controller.pinConfirmController.text) {
                    controller.register();
                  } else {
                    Ui.errorMessage(
                        message: "Les codes PIN ne correspondent pas");
                  }
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return false;
                },
              ).marginOnly(bottom: 20),
              controller.registerLoad.value
                  ? const CircularProgressIndicator()
                  : Container()
            ],
          ),
        )),
      ),
    );
  }
}
