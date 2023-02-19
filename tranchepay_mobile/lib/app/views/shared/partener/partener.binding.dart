import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tranchepay_mobile/app/views/shared/partener/partener.controller.dart';

class PartenerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartenerController>(() => PartenerController());
  }
}
