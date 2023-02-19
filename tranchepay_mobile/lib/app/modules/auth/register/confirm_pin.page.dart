import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class RegisterConfirmPinPage extends GetView<LoginController> {
  const RegisterConfirmPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(neutralColor),
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
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/key_pin.svg")
                    .marginOnly(bottom: 30),
                Text("Veuillez saisir votre code PIN pour continuer",
                        style: Get.textTheme.bodyMedium
                            ?.merge(TextStyle(color: Color(mainColor))))
                    .marginOnly(bottom: 30),
                PinCodeTextField(
                  length: 4,
                  keyboardType: TextInputType.number,
                  autoDismissKeyboard: true,
                  cursorColor: Color(mainColor),
                  textStyle: TextStyle(fontSize: 30, color: Color(mainColor)),
                  obscureText: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(10),
                    inactiveFillColor: Color(neutralColor),
                    activeColor: Color(mainColor),
                    inactiveColor: Ui.parseColorText("#F1F6F8"),
                    errorBorderColor: Colors.red,
                    borderWidth: 2,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeFillColor: Color(primaryColor),
                  ),
                  onCompleted: (v) {
                    print("Completed");
                    Get.toNamed(AppRoutes.clientProfile);
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: Get.context!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
