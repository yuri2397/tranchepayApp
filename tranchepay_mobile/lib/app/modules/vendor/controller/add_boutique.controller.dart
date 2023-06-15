import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranchepay_mobile/core/ui.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../../models/boutique.model.dart';
import '../../../services/vendor.service.dart';

class AddBoutiqueController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile> image = XFile('').obs;
  final boutique = Boutique().obs;

  final loading = false.obs;

  Future<void> _pickImage({required ImageSource source}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        image.value = pickedFile;
        image.refresh();
      } else {
        Ui.errorMessage(message: "Aucune image sélectionnée");
      }
    } catch (e) {
      print("FILE PICKER : $e");
    }
  }

  Future<void> pickImageFrom() async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.camera_alt_rounded),
            title: const Text("Prendre une photo", style: TextStyle(fontFamily: 'Poppins'),),
            onTap: () async {
              Get.back();
              await _pickImage(source: ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image_rounded),
            title: const Text("Choisir une photo",style: TextStyle(fontFamily: 'Poppins')),
            onTap: () async {
              Get.back();
              await _pickImage(source: ImageSource.gallery);
            },
          ),
        ]),
      ),
    );
  }



  Future<void> addVendorShop() async {
    loading.value = true;
    try {
      boutique.value.commercantId = localStorage.getVendor()?['id'];
      print(boutique.value.toJson());
      final response = await Get.find<VendorService>()
          .addBoutique(boutique: boutique.value, file: image.value);
      if (response != null) {
        Ui.successMessage(message: "Boutique ajoutée avec succès");
        Get.offAllNamed(AppRoutes.vendorModule);
      }
    } catch (e) {
      print("ADD VENDOR SHOP : $e");
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }


}