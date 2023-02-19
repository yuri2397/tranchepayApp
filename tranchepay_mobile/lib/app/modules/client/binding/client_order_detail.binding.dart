import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_order_detail.controller.dart';

class ClientOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientOrderDetailController>(
        () => ClientOrderDetailController());
  }
}
