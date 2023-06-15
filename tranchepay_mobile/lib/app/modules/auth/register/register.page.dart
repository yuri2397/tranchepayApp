import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/register.controller.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/widget/client_form.widget.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/widget/vendor_form_widget.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Inscription".toUpperCase(),
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
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height - 100,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Ui.parseColor("#E9EBEC")
                              ,borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: PrimaryButton(
                                  elevation: 0,
                                  disabled: controller.registerType.value ==
                                          UserType.client
                                      ? false
                                      : true,
                                  onPressed: () {
                                    controller.registerType.value =
                                        UserType.client;
                                  },
                                  child: Text('particulier'.toUpperCase()),
                                )),
                            Expanded(
                                flex: 1,
                                child: PrimaryButton(
                                  elevation: 0,
                                  disabled: controller.registerType.value ==
                                          UserType.vendor
                                      ? false
                                      : true,
                                  onPressed: () {
                                    controller.registerType.value =
                                        UserType.vendor;
                                  },
                                  child: Text('commerçant'.toUpperCase()),
                                ))
                          ],
                        ).marginSymmetric(horizontal: 4),
                      ),
                    ).marginOnly(bottom: 20, top: 10),
                    Text(
                      "Bienvenue sur TranchePay entrez votre numéro de téléphone pour continuer",
                      style: Get.textTheme.caption,
                      textAlign: TextAlign.center,
                    ).marginOnly(bottom: 30),
                    Obx(
                      () => controller.loading.value
                          ? const CircularProgressIndicator()
                          : controller.registerType.value == UserType.client
                              ? ClientFormWidget()
                              : VendorFormWidget(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
