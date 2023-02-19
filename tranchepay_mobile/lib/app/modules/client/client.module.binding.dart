import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_order_history.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_payment_history.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_profile.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_settings.controller.dart';

class ClientModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientModuleController>(
      () => ClientModuleController(),
    );

    Get.lazyPut<ClientProfileController>(
      () => ClientProfileController(),
    );

    Get.lazyPut<ClientOrderHistoryController>(
      () => ClientOrderHistoryController(),
    );

    Get.lazyPut<ClientPaymentHistoryController>(
      () => ClientPaymentHistoryController(),
    );

    Get.lazyPut<ClientSettingsController>(
      () => ClientSettingsController(),
    );
  }
}
