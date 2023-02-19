import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class PaymentTypeWidget extends Container {
  String code;
  String title;
  bool selected;
  Function onTap;
  PaymentTypeWidget(
      {required this.code,
      required this.title,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Ui.containerDecoration(),
      child: Stack(
        children: [
          GestureDetector(
              onTap: () => onTap(),
              child: Image.asset(
                "assets/icons/$code.png",
                width: 60,
                height: 60,
              ).marginAll(15)),
          Positioned(
            right: 8,
            top: 10,
            child: Visibility(
                visible: selected,
                child: Image.asset(
                  "assets/icons/checked.png",
                  width: 15,
                  height: 15,
                )),
          )
        ],
      ),
    );
  }
}
