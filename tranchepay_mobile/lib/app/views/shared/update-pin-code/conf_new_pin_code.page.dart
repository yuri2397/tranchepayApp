import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranchepay_mobile/app/views/shared/update-pin-code/update_pin_code.controller.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ConfNewPinCodePage extends GetView<UpdatePinCondeController> {
  const ConfNewPinCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Ui.parseColorText("#EDEDED"),
          title: Text(
            "Modifier Pin".toUpperCase(),
            style: Get.textTheme.headline2
                ?.merge(TextStyle(color: Color(mainColor))),
          ),
          centerTitle: true,
          leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios, color: Color(mainColor)))
              .marginOnly(right: 5),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.stepsText[controller.steps.value],
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(mainColor)),
              ).marginOnly(bottom: 50),
              PinCodeTextField(
                key: key,
                controller: controller.confPasswordController.value,
                length: 4,
                appContext: Get.context!,
                animationType: AnimationType.none,
                cursorColor: Color(mainColor),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textStyle: TextStyle(color: Color(mainColor)),
                pinTheme: PinTheme(
                    activeColor: Color(mainColor),
                    selectedColor: Color(mainColor),
                    disabledColor: Color(mainColor),
                    inactiveColor: Color(mainColor),
                    borderWidth: 3),
                onChanged: (String value) {
                  controller.confPin.value = value;
                },
                onCompleted: (String value) {
                  controller.confPin.value = value;
                  Get.log(
                      "${controller.pin} ${controller.newPin} ${controller.confPin}");
                  if (controller.newPin.value == value) {
                    controller.updatePin();
                  } else {
                    controller.newPasswordController.value.clear();
                    controller.steps.value = 1;
                    Ui.errorMessage(
                        message: 'Les deux code pin ne correspondent pas.');
                  }
                },
              ).marginSymmetric(horizontal: 20)
            ],
          )),
        ),
      ),
    );
  }
}
