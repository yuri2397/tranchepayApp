import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class LoginPinPage extends GetView<LoginController> {
  const LoginPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "CODE PIN".toUpperCase(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Obx(
            () => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/key_pin.svg")
                      .marginOnly(bottom: 30),
                  Text("Veuillez saisir votre code PIN pour continuer",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyMedium
                              ?.merge(TextStyle(color: Color(mainColor))))
                      .marginOnly(bottom: 30),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: PinCodeTextField(
                      length: 4,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autoDismissKeyboard: true,
                      cursorColor: Color(mainColor),
                      autoFocus: true,
                      textStyle:
                          TextStyle(fontSize: 30, color: Color(mainColor)),
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        borderRadius: BorderRadius.circular(10),
                        activeColor: Color(mainColor),
                        selectedColor: Color(mainColor),
                        inactiveColor: Color(neutralColor),
                        activeFillColor: Color(neutralColor),
                        selectedFillColor: Color(mainColor),
                        inactiveFillColor: Color(mainColor),
                        errorBorderColor: Colors.redAccent,
                        borderWidth: 2,
                        fieldHeight: 30,
                        fieldWidth: 30,
                      ),
                      onCompleted: (v) async {
                        controller.password.value = v;
                        await controller.login();
                      },
                      onChanged: (value) {
                        controller.password.value = value;
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: Get.context!,
                    ),
                  ),
                  controller.loading.value
                      ? const CircularProgressIndicator()
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
