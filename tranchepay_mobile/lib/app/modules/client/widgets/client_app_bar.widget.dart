import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class ClientAppBarWidget extends AppBar {
  Function()? plusButtonTap;
  Function()? notificationButtonTap;
  Function()? profileButtonTap;
  ClientAppBarWidget(
      {super.key,
      this.notificationButtonTap,
      this.profileButtonTap,
      this.plusButtonTap})
      : super(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                GestureDetector(
                  onTap: profileButtonTap,
                  child: Container(
                    width: 50,
                    height: 50,
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
                  child: Obx(
                    () => Text(
                            "${Get.find<ClientModuleController>().solde.value} FCFA",
                            style: Get.textTheme.headline5
                                ?.merge(TextStyle(color: Color(mainColor))))
                        .marginOnly(left: 10),
                  ),
                ),
                GestureDetector(
                        onTap: () => plusButtonTap,
                        child: SvgPicture.asset("assets/icons/plus.svg"))
                    .marginOnly(right: 20),
                GestureDetector(
                        onTap: notificationButtonTap,
                        child: SvgPicture.asset("assets/icons/bel.svg"))
                    .marginOnly(right: 5),
              ]),
            ),
          ),
        );
}
