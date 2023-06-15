import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/search_client.controller.dart';

class SearchClientBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => SearchClientController());  }

}