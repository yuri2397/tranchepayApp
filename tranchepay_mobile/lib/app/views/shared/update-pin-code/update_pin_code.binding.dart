import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tranchepay_mobile/app/views/shared/update-pin-code/update_pin_code.controller.dart';

class UpdateCodePinBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePinCondeController>(() => UpdatePinCondeController());
  }
}
