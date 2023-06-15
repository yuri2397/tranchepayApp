import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/vendor_home.controller.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/vendor_order.page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/widgets/home_grey_card.widget.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/ui.dart';

import '../../../../core/theme.colors.dart';
import '../widgets/order_history.widget.dart';

class VendorHomePage extends GetView<VendorHomeController> {
  const VendorHomePage({super.key});

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
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(controller.boutique.value.logo!),
                  ).marginOnly(right: 20),
                  Text(
                    "${controller.solde.value} FCFA",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Ui.parseColor("#D9D9D9")),
                  ),
                  GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset("assets/icons/bel.svg"))
                      .marginOnly(right: 10),
                ],
              ).paddingAll(10),
            ),
          ),
          body: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.searchClient),
                          child: SizedBox(
                            width: Get.width * .4,
                            child: HomeGreyCard(
                                title: "Ajouter une commande",
                                icon: Icons.shopping_cart_checkout_rounded),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * .4,

                          child: HomeGreyCard(
                              title: "Mes clients", icon: Icons.group_add_rounded),
                        ),

                      ],
                    ).marginOnly(bottom: 30),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(neutralColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Historique des commandes",
                          style: TextStyle(
                              color: Color(mainColor), fontFamily: 'Poppins')),
                    ).marginOnly(bottom: 30),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(neutralColor),
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                      ),
                      child: const VendorOrderHistoryWidget()),
                ],
              ),
            ),
          )
    );
  }
}
