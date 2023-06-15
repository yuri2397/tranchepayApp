import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/produit.model.dart';

class AddOrderController extends GetxController {
  final products = <Produit>[].obs;
  final formKey = GlobalKey<FormState>();
  final currentProduct = Produit().obs;
  final client = "".obs;

  void onInit() {
    print(Get.parameters['client_id']);
    if (Get.parameters != null && Get.parameters['client_id'] != null) {
      client.value = Get.parameters['client_id']!;
    }
    products.value = [];
    super.onInit();
  }

  void removeProduct(Produit produit) {
    products.remove(produit);
    products.refresh();
  }

  double get total => products.fold(
      0,
      (previousValue, element) =>
          previousValue + element.prixUnitaire! * element.quantite!);
}
