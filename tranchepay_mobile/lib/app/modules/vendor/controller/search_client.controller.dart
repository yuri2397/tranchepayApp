import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';

class SearchClientController extends GetxController {
  final clients = <Client>[].obs;
  final _clientService = Get.find<ClientService>();
  final loading = false.obs;
  final debunser = Debouncer(delay: const Duration(milliseconds: 300));

  Future<void> searchClient(String data) async {
    loading.value = true;
    try {
      debunser(() async {
        clients.value = await _clientService.index(params: {
          'search': data,
          'per_page': "15",
        });
        Get.log("DONE ${clients.length}");
        loading.value = false;
      });
    } catch (e) {
      print(e);
      loading.value = false;
    }
  }
}
