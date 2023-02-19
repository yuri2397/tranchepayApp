import 'package:flutter/material.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class PaymentListCardWidget extends StatelessWidget {
  List<Versement> payments;
  double totalRestant = 0;

  PaymentListCardWidget(
      {super.key, required this.payments, required this.totalRestant});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            border: Border.all(color: Ui.parseColorText("#849398"), width: 2)),
        child: Column(
          children: [
            ListView.separated(
              itemCount: payments.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) => Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${payments[index].via}",
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 12),
                      ),
                      Text(
                        formatDate(date: payments[index].dateTime!),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 12),
                      ),
                      Text(
                        "${payments[index].montant} FCFA",
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 12),
                      )
                    ]),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  Container(height: 1, color: Ui.parseColorText("#849398")),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TOTAL RESTANT",
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "$totalRestant FCFA",
                    style: const TextStyle(
                        color: Colors.red,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
