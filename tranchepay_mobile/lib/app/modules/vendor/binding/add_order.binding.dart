import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/add_order.controller.dart';

class AddOrderBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => AddOrderController());  }

}