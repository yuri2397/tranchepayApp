import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/setting.model.dart';
import 'package:tranchepay_mobile/core/helper.dart';

class SettingService extends GetxService {
  final setting = Setting().obs;

  Future<SettingService> init() async {
    var response = await Helper.getJsonFile('config/settings.json');
    setting.value = Setting.fromJson(response);
    Get.log("SETTINGS: ${setting.value.appName}");
    return this;
  }
}
