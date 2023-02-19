import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';
import 'package:tranchepay_mobile/core/widgets/tag.widget.dart';

class ClientOrderCardItem extends StatelessWidget {
  final Commande order;

  const ClientOrderCardItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Ui.containerDecoration(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(mainColor),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0.5, .5), // changes position of shadow
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "REF: ${order.reference?.toUpperCase()}",
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  TagWiget(
                    text: etatCommandeText(order.etatCommande!),
                    type: etatCommandeType(order.etatCommande!),
                  )
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PRIX TOTAL",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                Text(
                  "${order.prixTotal.toString()} FCFA",
                  style: const TextStyle(fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "COMMISSION",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                Text(
                  "${order.commission?.toInt()} FCFA",
                  style: const TextStyle(fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("BOUTIQUE", style: TextStyle(fontFamily: 'Poppins')),
                Text(
                  "${order.boutique?.nom}",
                  style: const TextStyle(fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "DATE COMMANDE",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                Text(
                  formatDate(date: order.dateTime!),
                  style: const TextStyle(fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "DATE LIMITE DE PAIEMENT",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                Text(formatDate(date: order.dateLimite!))
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.1),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.orderDetails,
                          parameters: {'order_id': order.id.toString()});
                    },
                    child: Text("Voir plus",
                        style: TextStyle(
                            color: Color(mainColor),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500))),
                Icon(
                  Icons.arrow_right_rounded,
                  color: Color(mainColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
