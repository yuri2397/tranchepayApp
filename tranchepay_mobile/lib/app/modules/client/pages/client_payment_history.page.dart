import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_app_bar.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_history.widget.dart';

import '../../../../core/theme.colors.dart';

class ClientPaymentPage extends StatefulWidget {
  const ClientPaymentPage({super.key});

  @override
  State<ClientPaymentPage> createState() => _ClientPaymentPageState();
}

class _ClientPaymentPageState extends State<ClientPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(neutralColor),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/icons/avatar.jpg'),
                  ),
                ),
              ),
            ).marginOnly(right: 5),
            Expanded(
              child: Text("HISTORIQUE DES PAIMENTS",
                  style: Get.textTheme.headline6
                      ?.merge(TextStyle(color: Color(mainColor))))
                  .marginOnly(left: 10),
            ),
          ]).marginAll(10),
        ),
      ),
      body: const ClientPaymentHistoryWidget(),
    );
  }
}
