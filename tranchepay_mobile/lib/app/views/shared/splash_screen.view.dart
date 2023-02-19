import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      bool isAuth = Get.find<LocalStorageService>().getIsLogged();
      Get.log("IS AUTH: $isAuth");
      if (isAuth) {
        if (Get.find<LocalStorageService>().getUserType() == 'client') {
          Get.offAllNamed(AppRoutes.clientModule);
        } else {
          Get.offAllNamed(AppRoutes.vendorDashboard);
        }
      } else {
        Get.offAllNamed(AppRoutes.loginNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              width: 100,
              height: 100,
            ).marginOnly(bottom: 20),
            SizedBox(
              width: Get.width * .5,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Color(accentColor)),
              ).paddingOnly(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}
