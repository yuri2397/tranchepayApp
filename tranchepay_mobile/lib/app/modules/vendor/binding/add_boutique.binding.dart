import 'package:get/get.dart';
import '../controller/add_boutique.controller.dart';

class AddBoutiqueBinding implements Bindings {
  @override
  void dependencies() {
    Get.log("AddBoutiqueBinding");
    Get.lazyPut<AddBoutiqueController>(
      () => AddBoutiqueController(),
    );
  }
}
