import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

import '../controller/vendor_account.controller.dart';
import '../widgets/home_grey_card.widget.dart';

class VendorAccountPage extends GetView<VendorAccountController> {
  const VendorAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ).marginOnly(right: 10),
                Text("PORTEFEUILLE",
                        style: Get.textTheme.headline5
                            ?.merge(TextStyle(color: Color(mainColor))))
                    .marginOnly(left: 10),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset("assets/icons/bel.svg"))
                        .marginOnly(right: 10),
                  ),
                ),
              ],
            ).paddingAll(10),
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(neutralColor),
                  borderRadius: BorderRadius.circular(20)),
              height: 120,
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("solde compte".toUpperCase(),
                          style: TextStyle(
                              color: Color(mainColor),
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                      .marginOnly(bottom: 20),
                  Text("100.000 FCFA".toUpperCase(),
                      style: TextStyle(
                          color: Color(mainColor),
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w700))
                      .marginOnly(bottom: 10)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width  * .4,
                    child: HomeGreyCard(
                        title: "Ajouter une \ncommande",
                        icon: Icons.shopping_cart_checkout_rounded),
                  ),
                  SizedBox(
                    width: Get.width  * .4,
                    child: HomeGreyCard(
                        title: "Mes clients", icon: Icons.group_add_rounded),
                  ),
                ],
              ).marginOnly(bottom: 30),
            ),
          ],
        ));
  }
}
