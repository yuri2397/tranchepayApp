import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';

class ClientPaymentHistoryController extends GetxController {
  final perPage = 10.obs;
  final page = 1.obs;
  final isLoading = false.obs;
  final payments = <Versement>[].obs;
  final _clientService = Get.find<ClientService>();
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchPayments();
  }

  Future<void> fetchPayments() async {
    try {
      isLoading.value = true;
      payments.value = (await _clientService.versements())!;
      Get.log("PAYMENTS: ${payments.value}");
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
