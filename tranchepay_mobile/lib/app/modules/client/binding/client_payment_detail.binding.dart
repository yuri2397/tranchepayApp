import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_payment_detail.controller.dart';

class ClientPaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientPaymentDetailController>(
        () => ClientPaymentDetailController());
  }
}
