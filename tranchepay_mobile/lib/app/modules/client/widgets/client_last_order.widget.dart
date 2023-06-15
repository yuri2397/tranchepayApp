import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';
import 'package:tranchepay_mobile/core/widgets/tag.widget.dart';

class ClientLastOrderWidget extends StatelessWidget {
  Commande order;
  ClientLastOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(20),
      width: Get.width,
      decoration:Ui.containerDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Derniere commande",
              style: Get.textTheme.headline5
                  ?.merge(TextStyle(color: Color(mainColor)))),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Réference:  ",
                  style: Get.textTheme.caption?.merge(
                      const TextStyle(fontSize: 12, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                "${order.reference?.toUpperCase()}",
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date d'achat:  ",
                  style: Get.textTheme.caption?.merge(
                      const TextStyle(fontSize: 12, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                formatDate(date: order.dateTime!),
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("À payer avant le:  ",
                  style: Get.textTheme.caption?.merge(
                      const TextStyle(fontSize: 12, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                formatDate(date: order.dateLimite!),
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status:  ",
                  style: Get.textTheme.caption?.merge(
                      const TextStyle(fontSize: 12, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 10,
              ),
              TagWiget(
                text: etatCommandeText(order.etatCommande!),
                type: etatCommandeType(order.etatCommande!),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.orderDetails,
                      parameters: {'order_id': order.id.toString()}),
                  child: Row(
                    children: [
                      Text("Détails",
                          style: Get.textTheme.caption?.merge(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(mainColor)))),
                      const SizedBox(
                        width: 3,
                      ),
                      Icon(Icons.arrow_circle_right_outlined,
                          color: Color(mainColor))
                    ],
                  )),
            ],
          ),

        ],
      ),
    );
  }
}
