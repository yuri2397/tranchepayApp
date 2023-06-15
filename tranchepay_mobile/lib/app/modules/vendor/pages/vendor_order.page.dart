import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme.colors.dart';
import '../controller/vendor_order.controller.dart';
import '../widgets/order_history.widget.dart';

class VendorOrderPage extends GetView<VendorOrderController> {
  const VendorOrderPage({super.key});

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
                backgroundImage: NetworkImage(controller.boutique.value.logo!),
              ).marginOnly(right: 10),
              Text("COMMANDES",
                      style: Get.textTheme.headline5
                          ?.merge(TextStyle(color: Color(mainColor))))
                  .marginOnly(left: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset("assets/icons/plus.svg"))
                      .marginOnly(right: 10),
                ).marginOnly(right: 10),
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
        child: Container(
            decoration: BoxDecoration(
                color: Color(neutralColor),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: const VendorOrderHistoryWidget()),
      ),
    );
  }
}
