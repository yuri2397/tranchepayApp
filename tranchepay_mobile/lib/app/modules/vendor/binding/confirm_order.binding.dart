import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/confirm_order.controller.dart';

class ConfirmOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmOrderController>(() => ConfirmOrderController());
  }
}
