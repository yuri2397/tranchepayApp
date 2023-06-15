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
          backgroundColor: Color(neutralColor),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/icons/avatar.jpg'),
                    ),
                  ),
                ),
              ).marginOnly(right: 5),
              Expanded(
                child: Text("PARAMETRES",
                    style: Get.textTheme.headline5
                        ?.merge(TextStyle(color: Color(mainColor))))
                    .marginOnly(left: 10),
              ),
            ]).marginAll(10),
          ),
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
              )
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
              )
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
              )
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
              )
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
              )
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
        ));
  }
}
