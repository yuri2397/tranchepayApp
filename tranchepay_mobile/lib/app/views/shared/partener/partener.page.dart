import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/views/shared/partener/partener.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class PartenerPage extends GetView<PartenerController> {
  const PartenerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Ui.parseColorText("#EDEDED"),
        title: Text(
          "Partenaires".toUpperCase(),
          style: Get.textTheme.headline2
              ?.merge(TextStyle(color: Color(mainColor))),
        ),
        centerTitle: true,
        leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios, color: Color(mainColor)))
            .marginOnly(right: 5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nos partenaires mobile money",
                style: Get.textTheme.caption
                    ?.merge(TextStyle(fontSize: 18, color: Color(mainColor))),
              ),
              Row(
                children: [
                  Image.asset("assets/images/wave.jpg").marginOnly(right: 20),
                  Image.asset("assets/images/om.jpg").marginOnly(right: 20),
                  Image.asset("assets/images/free.jpg").marginOnly(right: 20),
                ],
              ).marginOnly(top: 10, bottom: 30),
              Text(
                "Nos boutiques partenaires",
                style: Get.textTheme.caption
                    ?.merge(TextStyle(fontSize: 18, color: Color(mainColor))),
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/wave.svg")
                      .marginOnly(right: 20),
                  SvgPicture.asset("assets/icons/om.svg").marginOnly(right: 20),
                  SvgPicture.asset("assets/icons/free.svg")
                      .marginOnly(right: 20),
                ],
              ).marginOnly(top: 10, bottom: 30)
            ],
          ).marginSymmetric(vertical: 20),
        ),
      ),
    );
  }
}
