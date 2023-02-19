import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientPaymentDetailController extends GetxController {
  final solde = Get.find<ClientModuleController>().solde.obs;
  final _clientService = Get.find<ClientService>();
  final payment = Versement().obs;
  final hasError = false.obs;
  final loading = true.obs;

  @override
  void onInit() async {
    await findPaymentDetails();
    super.onInit();
  }

  Future<void> findPaymentDetails() async {
    loading.value = true;
    hasError.value = false;
    try {
      var response = await _clientService
          .detailsPayment(Get.parameters['payment_id']!, params: {
        'with[]': ['commande']
      });
      if (response != null) {
        payment.value = response;
      } else {
        Ui.errorMessage(message: 'Vérifier votre connexion.', title: 'Erreur');
        hasError.value = true;
      }
    } catch (e) {
      print(e);
    } finally {
      hasError.value = true;

      loading.value = false;
    }
  }
}
