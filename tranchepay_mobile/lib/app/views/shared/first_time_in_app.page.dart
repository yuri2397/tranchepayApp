import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class FirstTimeInstall extends StatelessWidget {
  FirstTimeInstall({super.key});

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        const Text(
                          "Ne faites pas qu’acheter!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              height: 2),
                          textAlign: TextAlign.center,
                        ).marginOnly(bottom: 10),
                        const Text(
                          "Achetez à votre",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.center,
                        ).marginOnly(bottom: 10),
                        Text(
                          "RYTHME",
                          style: TextStyle(
                              color: Color(accentColor),
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ).marginOnly(bottom: 20),
                      ],
                    )),
                Flexible(
                  flex: 2,
                  child: Image.asset("assets/images/logo.jpg",
                          width: 100, height: 100)
                      .marginOnly(bottom: 20),
                ),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                            width: Get.width,
                            child: PrimaryButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.login);
                                },
                                child: Text(
                                  "Connexion".toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ))).marginOnly(bottom: 10),
                        SizedBox(
                          width: Get.width,
                          child: SecondaryButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.register);
                              },
                              child: Text(
                                "Inscription".toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              )),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
