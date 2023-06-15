import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/views/shared/payment.controller.dart';

class PaymentWidget extends GetWidget<PaymentController>{
  List<String> modes = ['caisse', 'om','wave', 'free'];

   PaymentWidget({super.key, this.modes = const ['caisse', 'om','wave', 'free'] });


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/wave.jpg') ).marginOnly(right: 20),
          Text("Caisse", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins'),),
          Expanded(child: CheckboxListTile(value: true, onChanged: (value) {}),)
        ],
      ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/wave.jpg') ).marginOnly(right: 20),
            Text("Wave", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins'),),
            Expanded(child: CheckboxListTile(value: true, onChanged: (value) {}),)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/om.jpg') ).marginOnly(right: 20),
            Text("Orange Money", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins'),),
            Expanded(child: CheckboxListTile(value: true, onChanged: (value) {}),)
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/free.jpg') ).marginOnly(right: 20),
            Text("Free Money", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins'),),
            Expanded(child: CheckboxListTile(value: true, onChanged: (value) {}),)
          ],
        ),

    ],);
  }

}