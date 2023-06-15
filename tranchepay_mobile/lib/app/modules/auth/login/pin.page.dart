import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

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
            style: Get.textTheme.headline4
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
        body:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              Text("Veuillez entrer le code PIN",
                  style: TextStyle(
                    color: Color(darkColor),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ).marginOnly(bottom: 30),

              PinCodeTextField(
                appContext: context,
                length: 4,
                obscureText: true,
                autoUnfocus: true,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  inactiveFillColor: Color(neutralColor),
                  borderWidth: 3,
                  activeFillColor: Color(neutralColor),
                  selectedFillColor: Color(neutralColor),
                  selectedColor: Color(mainColor),
                  activeColor: Color(mainColor),
                  inactiveColor: Color(neutralColor),
                  fieldOuterPadding: EdgeInsets.all(10),
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) async {
                  controller.password.value = v;
                  controller.login();
                },
                onChanged: (value) {
                  controller.password.value = value;
                },
                beforeTextPaste: (text) {
                  return false;
                },
              ).marginOnly(bottom: 20),
              controller.loading.value
                  ?  CircularProgressIndicator(
                color: Color(mainColor),
              )
                  : Container()
            ],
          ).marginOnly(left: 30, right: 30, top: 30));
  }
}
