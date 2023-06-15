import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/vendor_module.controller.dart';

import 'controller/vendor_account.controller.dart';
import 'controller/vendor_home.controller.dart';
import 'controller/vendor_order.controller.dart';
import 'controller/vendor_settings.controller.dart';

class VendorModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorModuleController>(
      () => VendorModuleController(),
    );
    Get.lazyPut<VendorHomeController>(
          () => VendorHomeController(),
    );
    Get.lazyPut<VendorAccountController>(
          () => VendorAccountController(),
    );
    Get.lazyPut<VendorSettingsController>(
          () => VendorSettingsController(),
    );
    Get.lazyPut<VendorOrderController>(
          () => VendorOrderController(),
    );
  }
}
