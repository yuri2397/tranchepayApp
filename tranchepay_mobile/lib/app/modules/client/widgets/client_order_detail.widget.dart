import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_order_detail.controller.dart';
import 'package:tranchepay_mobile/app/views/shared/loader_screen.view.dart';
import 'package:tranchepay_mobile/app/views/shared/payment.controller.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';
import 'package:tranchepay_mobile/core/widgets/payment_list_card.widget.dart';
import 'package:tranchepay_mobile/core/widgets/tag.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../views/shared/payment_type.dart';

class ClientOrderDetailWidget extends GetView<ClientOrderDetailController> {
  final paymentController = PaymentController();

  ClientOrderDetailWidget({super.key});

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
            title: Text('DETAIL COMMANDE',
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
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    width: Get.width,
                    decoration:
                        Ui.containerDecoration(color: Color(neutralColor)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "REF: ${controller.order.value.reference?.toUpperCase()}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(mainColor)),
                          ).marginOnly(bottom: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date d'achat:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                formatDate(
                                    date: controller.order.value.dateTime!),
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
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
                                "Montant total:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${controller.order.value.prixTotal} FCFA",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
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
                                "Commission:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${controller.order.value.commission?.toInt()} FCFA",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "À payer avant :",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              TagWiget(
                                text: formatDate(
                                    date: controller.order.value.dateTime!),
                                type: TagType.danger,
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
                                "État commande:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              TagWiget(
                                text: etatCommandeText(
                                    controller.order.value.etatCommande!),
                                type: etatCommandeType(
                                    controller.order.value.etatCommande!),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          PaymentListCardWidget(
                            payments: controller.order.value.versements!,
                            totalRestant: restForPaid(controller.order.value),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                              width: Get.width,
                              child: PrimaryButton(
                                elevation: 1,
                                onPressed: () {
                                  /*_waitConfirmation(
                                      title: "Paiement en attends",
                                      code: "wave");*/
                                  Get.bottomSheet(_panel(), isDismissible: true, isScrollControlled: true);
                                },
                                child: const Text("Faire un pauement",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins')),
                              ))
                        ])),
              ),
      ),
    );
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 7,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8)),
              ).marginOnly(bottom: 20),
            ),
            const Text("Faire un versement",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16))
                .marginOnly(bottom: 20),
            TextFormField(
                controller: paymentController.amount,
                style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                keyboardType: TextInputType.phone,
                inputFormatters: const [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  Get.log("$value");
                  if (value != null) {
                    double amount = double.tryParse(value) ?? 0.0;
                    double rest = restForPaid(controller.order.value);
                    if (amount > rest) {
                      return 'Le montant restant est $rest FCFA';
                    }
                    if ((rest - 100) < 100 && amount < 100) {
                      return 'Il faut payer la totalité du montant restant';
                    }
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Montant à verser',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 18)),
                )).marginOnly(bottom: 30),
            TextFormField(
                    controller: paymentController.phone,
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      const UpperCaseTextFormatter(),
                      paymentController.formatter
                    ],
                    decoration: const InputDecoration(
                        hintText: 'Numéro de téléphone',
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18)))
                .marginOnly(bottom: 30),
            Obx(
              () => SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PaymentTypeWidget(
                      code: 'wave',
                      selected: paymentController.selected.value == 'wave',
                      title: 'Wave',
                      onTap: () => paymentController.paymentTypeChange('wave'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),

                    PaymentTypeWidget(
                      code: 'om',
                      selected: paymentController.selected.value == 'om',
                      title: 'Orange Money',
                      onTap: () => paymentController.paymentTypeChange('om'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    PaymentTypeWidget(
                      code: 'free',
                      selected: paymentController.selected.value == 'free',
                      onTap: () => paymentController.paymentTypeChange('free'),
                      title: 'Free Money',
                    ),
                    // PaymentTypeWidget(
                    //   code: 'visa',
                    //   selected: paymentController.selected.value == 'visa',
                    //   title: 'Visa',
                    //   onTap: () => paymentController.paymentTypeChange('visa'),
                    // ),
                  ],
                ),
              ),
            ).marginOnly(bottom: 30),
            Obx(
              () => SizedBox(
                width: Get.width,
                child: PrimaryButton(
                    elevation: 1,
                    onPressed: () async => paymentController.makePayment(
                        commandeId: "${controller.order.value.id}"),
                    child: paymentController.loading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "Suivant",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          )),
              ),
            )
          ]),
    );
  }


}
