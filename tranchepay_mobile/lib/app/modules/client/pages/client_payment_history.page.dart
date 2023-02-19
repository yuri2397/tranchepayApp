import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_app_bar.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_history.widget.dart';

class ClientPaymentPage extends StatefulWidget {
  const ClientPaymentPage({super.key});

  @override
  State<ClientPaymentPage> createState() => _ClientPaymentPageState();
}

class _ClientPaymentPageState extends State<ClientPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClientAppBarWidget(),
      body: const ClientPaymentHistoryWidget(),
    );
  }
}
