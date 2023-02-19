import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';

class ClientOrderHistoryController extends GetxController {
  final perPage = 10.obs;
  final page = 1.obs;
  final isLoading = false.obs;
  final orders = <Commande>[].obs;
  final RxInt solde = Get.find<ClientModuleController>().solde;
  final _clientService = Get.find<ClientService>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      orders.value = (await _clientService.commandes(params: {
        'with[]': ['boutique'],
      }))!;
      printInfo(info: orders.value.toString());
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    page.value = 1;
    orders.value = (await _clientService.commandes(params: {
      'with[]': ['boutique'],
    }))!;
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    page.value++;
    var response = (await _clientService.commandes(params: {
      'with[]': ['boutique'],
    }))!;
    print(response);
    if (response.isNotEmpty) {
      orders.addAll(response);
    } else {
      refreshController.loadNoData();
    }

    refreshController.loadComplete();
  }
}
