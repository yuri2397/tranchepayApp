import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_profile.controller.dart';
import 'package:tranchepay_mobile/app/views/shared/loader_screen.view.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';
import 'package:tranchepay_mobile/core/widgets/element.widget.dart';

class ClientUpdateProfileProfile extends GetView<ClientProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "profil".toUpperCase(),
          style: Get.textTheme.headline2
              ?.merge(TextStyle(color: Color(mainColor))),
        ),
        centerTitle: true,
      ),
      body: false
          ? LoaderScreen(
              message: "Completer votre profile.",
              paragraph:
                  "rendez sur l’espace compte pour compléter votre profil",
            )
          : _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width,
          decoration: Ui.containerDecoration(
            color: Color(neutralColor),
            borderRaduis: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.client.value.prenoms = value;
                  },
                  decoration: Ui.inputDecoration(
                      hintText: "Saissisez votre prénom", icon: Icons.person),
                ).marginOnly(top: 20),
                TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.client.value.nom = value;
                  },
                  decoration: Ui.inputDecoration(
                      hintText: "Saisissez votre nom", icon: Icons.person),
                ).marginOnly(top: 20),
                TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.client.value.adresse = value;
                  },
                  decoration: Ui.inputDecoration(
                      hintText: "Saissisez votre adresse",
                      icon: Icons.location_pin),
                ).marginOnly(top: 20),
                const SizedBox(
                  height: 50,
                ),
                /*Container(
                      padding: const EdgeInsets.all(20),
                      width: Get.width,
                      decoration: Ui.containerDecoration(),
                      child: Column(
                        children: [
                          Text(
                            "Carte de crédit",
                            style: Get.textTheme.headline6,
                          ).marginOnly(bottom: 8),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                foregroundColor: Color(mainColor),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  side: BorderSide(
                                      color: Color(mainColor), width: 1.3),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                  "Ajouter une carte de crédit".toUpperCase()))
                        ],
                      ),
                    ).marginOnly(bottom: 20),µ:*/
                SizedBox(
                  width: Get.width,
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        print(controller.client.value.toJson());
                      },
                      child: Text("VALIDER".toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ).marginOnly(top: 20),
                  ),
                )
              ],
            ),
          ),
        ).marginOnly(top: 120),
        SizedBox(
          width: Get.width,
          child: AddUserAvatarButton(
            onPressed: () => controller.pickImage(),
          ),
        ).marginOnly(top: 30),
      ],
    ));
  }
}
