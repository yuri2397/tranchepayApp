import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/mode_payement.model.dart';
import 'package:tranchepay_mobile/app/models/produit.model.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/add_order.controller.dart';
import 'package:tranchepay_mobile/app/services/payment.service.dart';

class ConfirmOrderController extends GetxController {
  final products = <Produit>[].obs;
  String? client;
  final loading = false.obs;
  final _paymentService = Get.find<PaymentService>();
  final modePayments = <ModePayement>[].obs;

  @override
  void onInit() async {
    super.onInit();
    client = Get.find<AddOrderController>().client.value;
    products.value = Get.find<AddOrderController>().products;
    await getModePayments();
  }

  Future<void> getModePayments() async {
    loading.value = true;
    modePayments.value = await _paymentService.modePayments(client!);
    loading.value = false;
  }
}
