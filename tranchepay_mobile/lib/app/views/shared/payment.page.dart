import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/views/shared/payment.controller.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class PaymentPage extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [_headerWidget(), _listPaymentTypeWidget()],
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back<String>(result: controller.selected.value),
              child: const Icon(Icons.arrow_back_ios),
            ).marginAll(10),
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.3),
              radius: 15,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Color(mainColor),
                    size: 14,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          child: Text(
            "Veuillez choisir votre mode de paiement",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ).marginSymmetric(vertical: 10),
      ],
    );
  }

  Widget _listPaymentTypeWidget() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: () => controller.selected.value = "wave",
            //   child: PaymentTypeWidget(
            //     code: "wave",
            //     labelName: "Wave",
            //     imageName: "wave",
            //     selected: controller.selected.value == "wave",
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // GestureDetector(
            //   onTap: () => controller.selected.value = "om",
            //   child: PaymentTypeWidget(
            //     code: "om",
            //     labelName: "Orange Money",
            //     imageName: "om",
            //     selected: controller.selected.value == "om",
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // GestureDetector(
            //   onTap: () => controller.selected.value = "free",
            //   child: PaymentTypeWidget(
            //     code: "free",
            //     labelName: "Free Money",
            //     imageName: "free",
            //     selected: controller.selected.value == "free",
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // GestureDetector(
            //   onTap: () => controller.selected.value = "visa",
            //   child: PaymentTypeWidget(
            //     selected: controller.selected.value == "visa",
            //     code: "visa",
            //     labelName: "Carte Bancaire",
            //     imageName: "visa",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
