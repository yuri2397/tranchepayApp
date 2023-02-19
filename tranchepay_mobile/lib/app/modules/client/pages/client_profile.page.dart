import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_profile.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_app_bar.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_last_order.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_history.widget.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class ClientProfilePage extends GetView<ClientProfileController> {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: controller.loading.value ? null : ClientAppBarWidget(),
        body: SingleChildScrollView(
          child: controller.loading.value
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(),
                ))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child:
                          ClientLastOrderWidget(order: controller.order.value),
                    ),
                    Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(primaryColor),
                                Color(primaryMainColor),
                              ],
                            )),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Envoyez une demande de payement par tranche",
                                    style: TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SecondaryButton(
                                    onPressed: () {},
                                    child: Text("DEMANDE",
                                        style: TextStyle(
                                            color: Color(primaryColor))))
                              ],
                            )
                          ],
                        )).marginSymmetric(vertical: 10, horizontal: 20),
                    const SizedBox(
                      height: 20,
                    ),
                    const ClientPaymentHistoryWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
