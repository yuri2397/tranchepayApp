import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_settings.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientSettingsPage extends GetView<ClientSettingsController> {
  const ClientSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Ui.parseColorText("#EDEDED"),
          title: Text(
            "PARAMETRES".toUpperCase(),
            style: Get.textTheme.headline2
                ?.merge(TextStyle(color: Color(mainColor))),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            TextButton(
              onPressed: (() => Get.toNamed(AppRoutes.parteners)),
              child: ListTile(
                title: const Text('Partenaires',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ).marginOnly(bottom: 20, top: 20),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.updatePinCode),
              child: ListTile(
                title: const Text(
                  'Modifier code pin',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ).marginOnly(bottom: 20),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.helpCenter),
              child: ListTile(
                title: const Text(
                  'Centre d’aide',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ).marginOnly(bottom: 20),
            ),
            TextButton(
              onPressed: () {
                Get.log("SHARE APP");
              },
              child: ListTile(
                title: const Text(
                  'Partager l’application',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ).marginOnly(bottom: 20),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.deplafonnement),
              child: ListTile(
                title: const Text(
                  'Déplafonnenemet compte',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ).marginOnly(bottom: 20),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.generalInfo),
              child: ListTile(
                title: const Text(
                  'Information générale',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  color: Color(mainColor),
                  size: 30,
                ),
              ),
            )
          ],
        ).marginSymmetric(vertical: 20, horizontal: 10));
  }
}
