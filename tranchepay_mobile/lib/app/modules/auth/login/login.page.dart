import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.controller.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(neutralColor),
        title: Text(
          "CONNEXION".toUpperCase(),
          style: Get.textTheme.headline3
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
      ),*/
      body:Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Text(
                    "Votre numéro de téléphone",
                    style: TextStyle(
                      color: Color(darkColor),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ).marginOnly(bottom: 30),
                ),
                IntlPhoneField(
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone',
                    labelStyle: TextStyle(
                      color: Color(darkColor),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkColor)
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  initialCountryCode: 'SN',
                  countries: const ['SN'],
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  keyboardType: TextInputType.number,
                  controller: controller.inputController,
                ).marginOnly(bottom: 20),
                Obx(() => controller.loading.value
                    ? Center(
                      child:  CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(mainColor)),
                        ),
                    )
                    : SizedBox(
                  width: Get.width,
                      child: PrimaryButton(
                        elevation: 0,
                          onPressed: () async {
                            Get.log(
                                "username: ${controller.inputController.text}");
                            await controller.checkPhoneNumber();
                          },
                          child: Text(
                            "Suivant".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ).marginOnly(bottom: 20),
                    )).marginOnly(bottom: 10),
                SizedBox(
                  width: Get.width,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Créer un compte",
                          style: TextStyle(
                            color: Color(mainColor),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ).marginOnly(right: 10),
                        Icon(
                          Icons.forward,
                          color: Color(mainColor),
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
