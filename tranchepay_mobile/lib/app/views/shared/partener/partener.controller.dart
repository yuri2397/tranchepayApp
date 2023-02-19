import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/partener.model.dart';
import 'package:tranchepay_mobile/app/services/shared.service.dart';

class PartenerController extends GetxController {
  final parteners = <Partener>[].obs;
  final loading = true.obs;
  final _sharedService = Get.find<SharedService>();
  final error = false.obs;

  @override
  void onInit() async {
    await fetchPartenersList();
    super.onInit();
  }

  Future<void> fetchPartenersList() async {
    error.value = false;
    try {
      loading.value = true;
      var response = await _sharedService.parteners(params: {
        'with[]': ['type']
      });

      if (response != null) {
        parteners.value = response;
      } else {
        error.value = true;
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
