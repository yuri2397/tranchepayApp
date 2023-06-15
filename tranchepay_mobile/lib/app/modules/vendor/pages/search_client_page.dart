import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/add_order.controller.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/search_client.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class SearchClientPage extends GetView<SearchClientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back_ios,
                            color: Color(mainColor))),
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: TextField(
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          onChanged: (value) => controller.searchClient(value),
                          decoration: InputDecoration(
                            hintText: "Rechercher un client",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(neutralColor),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child:
                          const Icon(Icons.qr_code_scanner_rounded, size: 30),
                    ).marginOnly(left: 10, right: 10, top: 10, bottom: 10)
                  ],
                ).marginOnly(left: 15, right: 15, top: 10, bottom: 10),
              ),
              controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(color: Color(mainColor)),
                    )
                  : controller.clients.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: SvgPicture.asset(
                                "assets/images/search_user.svg",
                                width: 200,
                              ),
                            ).marginSymmetric(vertical: 30),
                            Text("Aucun client trouvé",
                                    style: Get.textTheme.headline4)
                                .marginOnly(bottom: 30),
                            SecondaryButton(
                                elevation: 0,
                                onPressed: () {},
                                child: const Text("Ajouter un client"))
                          ],
                        ))
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: controller.clients.length,
                              itemBuilder: (context, index) => ListTile(
                                onTap: () => Get.toNamed(AppRoutes.addOrder,
                                    parameters: {
                                      'client_id':
                                          "${controller.clients[index].id}"
                                    }),
                                leading: CircleAvatar(
                                  backgroundColor: Color(neutralColor),
                                  radius: 25,
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 30,
                                    color: Color(mainColor),
                                  ),
                                ),
                                title: Text(
                                    "${controller.clients[index].prenoms} ${controller.clients[index].nom}",
                                    style: Get.textTheme.headline4),
                                subtitle: Text(
                                    "${controller.clients[index].telephone}",
                                    style: Get.textTheme.headline6),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
