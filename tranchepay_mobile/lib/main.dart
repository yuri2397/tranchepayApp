import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranchepay_mobile/app/services/auth.service.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/app/services/payement.service.dart';
import 'package:tranchepay_mobile/app/services/settings.service.dart';
import 'package:tranchepay_mobile/app/services/shared.service.dart';
import 'package:tranchepay_mobile/app/views/shared/payment.controller.dart';
import 'package:tranchepay_mobile/app/views/shared/utils.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:tranchepay_mobile/core/routes/app_routing.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/themes/light.theme.dart';

import 'firebase_options.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  initFirebase();
  await GetStorage.init('tranchepay');
  Get.put<LocalStorageService>(LocalStorageService(), permanent: true);

  await Get.putAsync(() => SettingService().init());
  await Get.putAsync(() => ApiClient().init());

  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => ClientService().init());
  await Get.putAsync(() => SharedService().init());
  Get.lazyPut<PaymentService>(() => PaymentService());

  Get.log('All services started...');
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(
    GetMaterialApp(
      title: Get.find<SettingService>().setting.value.appName!,
      initialRoute: AppRoutes.initial,
      getPages: AppRouting.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      scrollBehavior: MyBehavior(),
      theme: LightTheme().themeData,
    ),
  );
}
