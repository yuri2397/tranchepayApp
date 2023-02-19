import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/make_payment.controller.dart';

class MakePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakePaymentController>(() => MakePaymentController());
  }
}
