import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_payment_detail.controller.dart';
import 'package:tranchepay_mobile/app/views/shared/loader_screen.view.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/tag.widget.dart';

class ClientPaymentDetailWidget extends GetView<ClientPaymentDetailController> {
  const ClientPaymentDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: Color(mainColor)),
            ),
            title: Text('DETAIL TRANSACTION',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Color(mainColor),
                    fontWeight: FontWeight.bold))),
        body: controller.loading.value
            ? LoaderScreen(
                message: 'Chargement des données...',
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   child: Text(
                      //     formatDate(date: controller.payment.value.createdAt!),
                      //     style: TextStyle(
                      //         color: Color(mainColor),
                      //         fontFamily: 'Poppins',
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ).marginOnly(bottom: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset("assets/images/wave.jpg"),
                          ).marginOnly(left: 10, right: 20),
                          Text("${controller.payment.value.via}")
                        ],
                      ).marginOnly(bottom: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Montant:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${controller.payment.value.montant} FCFA",
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Date:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            formatDate(
                                date: controller.payment.value.createdAt!),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ref. commande:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${controller.payment.value.commande?.reference}",
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Délais de versement:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          TagWiget(
                            text: formatDate(
                                date: controller.payment.value.dateTime!),
                            type: TagType.danger,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
