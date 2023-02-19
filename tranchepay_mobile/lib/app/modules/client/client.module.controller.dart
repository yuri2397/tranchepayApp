import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_payment_history.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_profile.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_settings.page.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_order_history.widget.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientModuleController extends GetxController {
  final _clientService = Get.find<ClientService>();
  final solde = 0.obs;

  final _storage = Get.find<LocalStorageService>();
  final loading = true.obs;
  final pages = <PersistentBottomNavBarItem>[];

  final screens = [
    const ClientProfilePage(),
    const ClientOrderHistoryWidget(),
    const ClientPaymentPage(),
    const ClientSettingsPage()
  ];

  List<PersistentBottomNavBarItem> navBarsItems() => pages;

  List<Widget> buildScreens() => screens;

  final selectedPagesIndex = 0.obs;

  void routerOutlet(int index) {
    selectedPagesIndex.value = index;
  }

  @override
  void onInit() async {
    pages.add(
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          iconSize: 30,
          inactiveIcon: const Icon(Icons.home_rounded),
          title: 'Accueil',
          inactiveColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Color(primaryColor),
          activeColorSecondary: Color(primaryColor)),
    );
    pages.add(PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_bag_outlined),
        iconSize: 30,
        inactiveIcon: const Icon(Icons.shopping_bag_outlined),
        title: 'Commandes',
        inactiveColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Color(primaryColor),
        activeColorSecondary: Color(primaryColor)));
    pages.add(
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.download_rounded),
          iconSize: 30,
          inactiveIcon: const Icon(Icons.download_rounded),
          title: 'Versements',
          inactiveColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Color(primaryColor),
          activeColorSecondary: Color(primaryColor)),
    );
    pages.add(
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings_rounded),
          iconSize: 30,
          inactiveIcon: const Icon(Icons.settings_rounded),
          title: 'Paramètres',
          inactiveColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Color(primaryColor),
          activeColorSecondary: Color(primaryColor)),
    );
    await getSolde();
    super.onInit();
  }

  Future<void> getSolde() async {
    loading.value = false;
    try {
      int? solde = await _clientService.solde();
      if (solde != null) {
        this.solde.value = solde;
        this.solde.refresh();
      }

      _storage.setSolde(this.solde.value);
    } catch (e) {
      Get.log("PARSER INST ${e.toString()}");
      Ui.errorMessage(message: 'Une erreur s\'est produite');
    } finally {
      loading.value = false;
    }
  }

  Future<bool> onWillPop() async {
    if (selectedPagesIndex.value == 0) {
      return true;
    } else {
      selectedPagesIndex.value = 0;
      return false;
    }
  }
}
