import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/vendor_order.controller.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class VendorOrderHistoryWidget extends GetView<VendorOrderController> {
  const VendorOrderHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? Center(
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(color: Color(mainColor))))
          : controller.orders.isEmpty
              ? Text("VIDE")
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                                    backgroundColor: Color(neutralColor),
                                    radius: 25,
                                    child: Icon(Icons.shopping_bag_rounded,
                                        size: 30, color: Color(mainColor)))
                                .marginOnly(right: 10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  controller.orders[index].reference
                                          ?.toUpperCase() ??
                                      "",
                                  style: Get.textTheme.headline6?.merge(
                                      TextStyle(color: Color(darkColor))),
                                ).marginOnly(bottom: 8),
                                Text(
                                    formatDate(
                                            date: controller
                                                .orders[index].createdAt!) ??
                                        "",
                                    style: Get.textTheme.caption?.merge(
                                        TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(darkColor))))
                              ],
                            )),
                            Text(
                              MoneyFormatter(amount: controller
                                  .orders[index].prixTotal ?? 0,
                                          settings: MoneyFormatterSettings(symbol: "cfa", fractionDigits: 0, decimalSeparator: ",", thousandSeparator: '.')).output.symbolOnRight ?? "",
                              style: Get.textTheme.headline6,
                            )
                          ],
                        ),
                      ).marginOnly(bottom: 10),
                  separatorBuilder: (_, index) => Divider(
                        height: 1.5,
                        color: Color(neutralColor),
                      ),
                  itemCount: controller.orders.length),
    );
  }
}
