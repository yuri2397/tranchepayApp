import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';

bool isAuth(){
  return Get.find<LocalStorageService>().getIsLogged();
}

LocalStorageService get localStorage => Get.find<LocalStorageService>();