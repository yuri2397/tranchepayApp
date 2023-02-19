import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class Ui {
  static errorMessage(
      {String title = "Erreur", String message = "Une erreur est survenue"}) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
    ;
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static successMessage(
      {String title = "Notification",
      String message = "Opération terminée avec succès"}) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green[600],
        snackPosition: SnackPosition.BOTTOM);
  }

  static Color parseColorText(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static containerDecoration(
      {Color? color, BorderRadiusGeometry? borderRaduis}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: borderRaduis ?? BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0.5, .5), // changes position of shadow
        ),
      ],
    );
  }

  static inputDecoration({
    String? labelText,
    String? hintText,
    String? prefixText,
    String? suffixText,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixText: prefixText,
      suffixText: suffixText,
      prefixIcon: Icon(icon),
      labelStyle: Get.textTheme.bodyText1,
      hintStyle: Get.textTheme.bodyText1,
      contentPadding: const EdgeInsets.all(12),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(neutralColor)),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(primaryColor))),
    );
  }
}
