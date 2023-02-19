import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/views/shared/status_tag.widget.dart';
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
      width: Get.width,
      decoration: BoxDecoration(
        color: Ui.parseColorText("#EDEDED"),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Ui.parseColorText("#EDEDED"),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(.5, .5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Derniere commande",
              style: Get.textTheme.headline4
                  ?.merge(TextStyle(color: Color(mainColor)))),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Réference:  ",
                  style: Get.textTheme.caption
                      ?.merge(TextStyle(fontSize: 16, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                "${order.reference?.toUpperCase()}",
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date d'achat:  ",
                  style: Get.textTheme.caption
                      ?.merge(TextStyle(fontSize: 16, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                formatDate(date: order.dateTime!),
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("À payer avant le:  ",
                  style: Get.textTheme.caption
                      ?.merge(TextStyle(fontSize: 16, fontFamily: 'Poppins'))),
              const SizedBox(
                width: 20,
              ),
              Text(
                formatDate(date: order.dateLimite!),
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.caption?.merge(
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status:  ",
                  style: Get.textTheme.caption?.merge(
                      const TextStyle(fontSize: 16, fontFamily: 'Poppins'))),
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
              Row(
                children: [
                  TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.orderDetails,
                          parameters: {'order_id': order.id.toString()}),
                      child: Text("Détails",
                          style: Get.textTheme.caption?.merge(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(mainColor))))),
                  Icon(Icons.arrow_circle_right_outlined,
                      color: Color(mainColor))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Get.width,
            child: PrimaryButton(
                elevation: 0,
                onPressed: () {},
                child: Text("Faire un versement".toUpperCase(),
                    style: Get.textTheme.button)),
          )
        ],
      ),
    );
  }
}
