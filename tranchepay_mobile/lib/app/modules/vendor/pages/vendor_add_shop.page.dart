import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';
import '../../../../core/theme.colors.dart';
import '../controller/add_boutique.controller.dart';

class VendorAddShopPage extends GetView<AddBoutiqueController> {
  const VendorAddShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Ma boutique".toUpperCase(),
            style: Get.textTheme.headline2
                ?.merge(TextStyle(color: Color(mainColor))),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(mainColor)),
            onPressed: () => Get.back(),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/icons/help.svg",
                width: 35,
                height: 35,
              ).marginOnly(right: 20),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ajouter les informations de votre boutique.",
                  style: Get.textTheme.headline3
                      ?.merge(TextStyle(color: Color(mainColor))),
                ).marginOnly(bottom: 30),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.pickImageFrom(),
                      child: Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 25,
                                color: Colors.grey[400],
                              ),
                              Text(
                                "Ajouter votre logo",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.caption?.merge(TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins')),
                              ),
                            ],
                          )),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: controller.image.value.path.isNotEmpty
                          ? Image.file(
                              File(controller.image.value.path),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                    ).marginOnly(left: 20),
                  ],
                ).marginOnly(bottom: 30),
                TextFormField(
                  style: TextStyle(color: Color(mainColor), fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Nom de la boutique',
                    hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(mainColor)),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Veuillez saisir le nom de la boutique';
                    } else if (value != null && value.length < 2) {
                      return 'Veuillez saisir un nom correct';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.boutique.value.nom = value,
                ).marginOnly(bottom: 20),
                TextFormField(
                  style: TextStyle(color: Color(mainColor), fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Adresse de la boutique',
                    hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(mainColor)),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Veuillez saisir l\'adresse de la boutique';
                    } else if (value != null && value.length < 2) {
                      return 'Veuillez saisir une adresse correcte';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      controller.boutique.value.addresse = value,
                ).marginOnly(bottom: 20),
                TextFormField(
                  style: TextStyle(color: Color(mainColor), fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Numéro de téléphone",
                    hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(mainColor)),
                    ),
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '+221 ## ### ## ##',
                        filter: {"#": RegExp(r'\d')}),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Veuillez saisir le numéro de téléphone';
                    } else if (value != null && value.length < 17) {
                      return 'Veuillez saisir un numéro correct';
                    }
                    return null;
                  },
                  onChanged: (value) =>
                      controller.boutique.value.telephone = value,
                ).marginOnly(bottom: 40),
                controller.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: Get.width,
                        child: PrimaryButton(
                          elevation: 0,
                          loading: controller.loading.value,
                          onPressed: () => controller.addVendorShop(),
                          child: Text(
                            "Créer votre compte".toUpperCase(),
                            style: TextStyle(
                                color: Color(mainColor),
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
