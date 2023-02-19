import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_deplafonnement.controller.dart';

class ClientDeplafonnementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientDeplafonnementController>(
        () => ClientDeplafonnementController());
  }
}
