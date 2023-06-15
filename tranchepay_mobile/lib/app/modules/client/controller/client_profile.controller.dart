import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/utils/helpers.dart';

import '../../../services/local_storage.service.dart';

class ClientProfileController extends GetxController {
  final client = Client().obs;
  final _clientService = Get.find<ClientService>();
  final loading = true.obs;
  final updateLoad = false.obs;
  final RxInt solde = Get.find<ClientModuleController>().solde;
  final ImagePicker _picker = ImagePicker();
  final order = Commande().obs;
  late XFile? image;
  final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key


  @override
  void onInit() async {
    if(isAuth()){
        client.value = Client.fromJson(Get.find<LocalStorageService>().getClient()!);
    }
    await getLastOrder();
    super.onInit();
  }

  Future<void> store() async {
    updateLoad.value = true;
    //var response = await _clientService.store(client.value);
    updateLoad.value = false;
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
    } else {
      Ui.errorMessage(message: 'Veuillez choisir une image');
    }
  }

  Future<void> getLastOrder() async {
    try {
      loading.value = true;
      var response = await _clientService.commandes(params: {
        'per_page': '1',
        'page': '1',
        'with[]': ['produits', 'boutique', 'versements']
      });

      if (response != null && response.isNotEmpty) {
        order.value = response[0];
      } else {
        Ui.errorMessage(message: 'Vérifier votre connexion internet');
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
