import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

import '../controller/confirm_order.controller.dart';

class ConfirmOrderPage extends GetView<ConfirmOrderController> {
  const ConfirmOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios, color: Color(mainColor))),
                Text("valider commande".toUpperCase(),
                        style: Get.textTheme.headline5
                            ?.merge(TextStyle(color: Color(mainColor))))
                    .marginOnly(left: 10),
                GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.credit_score_rounded,
                            size: 30, color: Color(mainColor)))
                    .marginOnly(right: 10),
              ],
            ).paddingAll(10),
          ),
        ),
        body: SingleChildScrollView(
          child: controller.loading.value
              ? Center(
                      child: CircularProgressIndicator(color: Color(mainColor)))
                  .marginSymmetric(horizontal: 20, vertical: 20)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(neutralColor),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
