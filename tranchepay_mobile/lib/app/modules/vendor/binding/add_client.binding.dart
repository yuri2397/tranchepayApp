import 'package:get/get.dart';

import '../controller/add_client.controller.dart';

class AddClientBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => AddClientController());  }

}