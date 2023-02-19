import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class ClientPaymentCardItem extends StatelessWidget {
  final Versement payment;

  const ClientPaymentCardItem({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.toNamed(AppRoutes.paymentDetails,
          parameters: {'payment_id': payment.id.toString()}),
      child: ListTile(
        title: Text(
          payment.via!.toUpperCase(),
          style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        horizontalTitleGap: 20,
        minVerticalPadding: 10,
        subtitle: Text("${payment.reference}"),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.payment_rounded,
            color: Color(mainColor),
            size: 30,
          ) /* SvgPicture.asset('assets/icons/${payment.via?.toLowerCase()}.svg')*/,
        ),
        trailing: Text(
          "${payment.montant} FCFA",
          style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
