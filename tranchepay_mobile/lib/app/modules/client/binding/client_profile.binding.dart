import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_profile.controller.dart';

class ClientProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientProfileController>(
      () => ClientProfileController(),
    );
  }
}
