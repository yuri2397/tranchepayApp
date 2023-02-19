import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(neutralColor),
        title: Text(
          "CONNEXION".toUpperCase(),
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
                const Text(
                  "Bienvenue sur TranchePay entrez votre numéro de téléphone pour continuer",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ).marginOnly(bottom: 30),
                TextFormField(
                        controller: controller.inputController,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Poppins'),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          const UpperCaseTextFormatter(),
                          controller.formatter,
                        ],
                        decoration: InputDecoration(
                            hintText: 'Numéro de téléphone',
                            hintStyle: TextStyle(color: Color(mainColor))))
                    .marginOnly(bottom: 50),
                Obx(() => controller.loading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : PrimaryButton(
                        onPressed: () async {
                          Get.log(
                              "username: ${controller.inputController.text}");
                          // if (controller.username.value.length < 9) {
                          //   Ui.errorMessage(
                          //       title: "Erreur",
                          //       message: "Numéro de téléphone invalide");
                          //   return;
                          // }
                          await controller.checkPhoneNumber();
                        },
                        child: Text(
                          "Continuer".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ).marginOnly(bottom: 20))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
