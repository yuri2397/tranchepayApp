import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class PrimaryButton extends ElevatedButton {
  bool? disabled;
  bool? loading;
  double elevation = 2;
  PrimaryButton({
    Key? key,
    this.disabled = false,
    required super.onPressed,
    this.loading = false,
    this.elevation = 2,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            elevation: disabled! ? 0 : elevation,
            foregroundColor: Color(mainColor),
            backgroundColor:
                disabled ? Color(neutralColor) : Get.theme.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
}

class SecondaryButton extends ElevatedButton {
  bool? disabled;
  double? elevation = 0;
  SecondaryButton({
    Key? key,
    this.disabled = false,
    required VoidCallback onPressed,
    this.elevation = 2,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            foregroundColor: Colors.white,
            elevation: disabled! ? 0 : elevation,
            backgroundColor: Color(mainColor),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Color(primaryColor), width: 1),
            ),
          ),
        );
}
