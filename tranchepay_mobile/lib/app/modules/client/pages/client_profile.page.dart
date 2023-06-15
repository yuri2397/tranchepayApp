import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_profile.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_app_bar.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_last_order.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_history.widget.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

import '../../../views/shared/text_group.widget.dart';

class ClientProfilePage extends GetView<ClientProfileController> {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.key,
        backgroundColor: Color(neutralColor),
        appBar: controller.loading.value
            ? null
            : ClientAppBarWidget(
                profileButtonTap: () =>
                    controller.key.currentState?.openDrawer(),
              ),
        drawer: _drawer(),
        body: SingleChildScrollView(
          child: controller.loading.value
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(),
                ))
              : Column(
                  children: [
                          controller.order.value.id == null ? Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(20),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Ui.parseColorText("#FFFFFF"),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Ui.parseColorText("#EDEDED"),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(.2, .5), // changes position of shadow
                                ),
                              ],
                            ),
                            child:const Text("Bienvenue sur TranchePay, payer vos commandes à votre rythme.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),

                          ) : ClientLastOrderWidget(order: controller.order.value),

                    // Container(
                    //     width: Get.width,
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 20, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         gradient: LinearGradient(
                    //           begin: Alignment.centerLeft,
                    //           end: Alignment.centerRight,
                    //           colors: [
                    //             Color(primaryColor),
                    //             Color(primaryMainColor),
                    //           ],
                    //         )),
                    //     child: Stack(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const Expanded(
                    //               child: Text(
                    //                 "Envoyez une demande de payement par tranche",
                    //                 style: TextStyle(
                    //                     overflow: TextOverflow.clip,
                    //                     fontSize: 20,
                    //                     fontFamily: 'Poppins',
                    //                     fontWeight: FontWeight.w300),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 20,
                    //             ),
                    //             SecondaryButton(
                    //                 onPressed: () {},
                    //                 child: Text("DEMANDE",
                    //                     style: TextStyle(
                    //                         color: Color(primaryColor))))
                    //           ],
                    //         )
                    //       ],
                    //     )).marginSymmetric(vertical: 10, horizontal: 20),
                    const ClientPaymentHistoryWidget(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _drawer() {
    return Container(
        height: Get.height,
        width: Get.width,
        decoration: Ui.containerDecoration(borderRaduis: BorderRadius.zero),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.key.currentState?.closeDrawer(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(mainColor),
                        size: 20,
                      ),
                    ).marginAll(8),
                    Expanded(
                        child: Text("Profil".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Get.textTheme.headline5
                                ?.merge(TextStyle(color: Color(mainColor)))))
                  ],
                ).marginSymmetric(horizontal: 20, vertical: 8),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Color(neutralColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextGroupWidget(
                              title: "Prénom & Nom", subTitle: "${controller.client.value.prenoms} ${controller.client.value.nom}")
                          .marginOnly(bottom: 10),
                      TextGroupWidget(
                              title: "Téléphone", subTitle: "${controller.client.value.telephone}")
                          .marginOnly(bottom: 10),
                      TextGroupWidget(
                              title: "Adresse ", subTitle: "${controller.client.value.adresse ?? 'Non définie'}")
                          .marginOnly(bottom: 50),

                      SizedBox(
                        width: Get.width,
                        child: GestureDetector(
                          onTap: () async => Get.defaultDialog(
                            title: 'Se déconnecter',
                            content: Text('Voulez-vous vraiment contunier?'),
                            confirmTextColor: Colors.white,
                            textConfirm: 'Confirmer!!',
                            onConfirm: () async => await Get.find<AuthService>().logout(),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.output_rounded,
                                color: Color(mainColor),
                                size: 20,
                              ).marginOnly(right: 10),
                              Expanded(
                                  child: Text(
                                "Se déconnecter",
                                style: TextStyle(color: Color(mainColor), fontSize: 13, fontFamily: 'Poppins'),
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
