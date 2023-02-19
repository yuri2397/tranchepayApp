import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/make_payment.controller.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class MakePaymentPage extends GetView<MakePaymentController> {
  const MakePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, color: Color(mainColor)),
          ),
          backgroundColor:
              const Color.fromARGB(255, 214, 214, 214).withOpacity(0.5),
          title: Text("Faire un versement".toUpperCase(),
              style: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700))),
      body: SingleChildScrollView(
          child: Column(
        children: [Text('')],
      )),
    );
  }
}
