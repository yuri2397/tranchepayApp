import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_payment_history.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_profile.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_settings.page.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_order_history.widget.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/vendor_account.page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/vendor_home.page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/vendor_order.page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/vendor_settings.page.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class VendorModuleController extends GetxController {
  final _clientService = Get.find<ClientService>();
  final solde = 10.obs;
  final PageController _pageController = PageController();

  final _storage = Get.find<LocalStorageService>();
  final loading = true.obs;
  final pages = <BottomNavyBarItem>[
    BottomNavyBarItem(
        activeColor: Color(mainColor),
        icon: SvgPicture.asset("assets/icons/bb_1.svg"),
        title: Text("Accueil", style: TextStyle(color: Color(mainColor)))),
    BottomNavyBarItem(
        activeColor: Color(mainColor),
        icon: SvgPicture.asset("assets/icons/bb_2.svg"),
        title: Text("Commandes", style: TextStyle(color: Color(mainColor)))),
    BottomNavyBarItem(
        activeColor: Color(mainColor),
        icon: SvgPicture.asset("assets/icons/bb_3.svg"),
        title: Text("PORTEFEUILLE", style: TextStyle(color: Color(mainColor)))),
    BottomNavyBarItem(
      activeColor: Color(mainColor),
      icon: SvgPicture.asset("assets/icons/bb_4.svg"),
      title: Text("Parametres", style: TextStyle(color: Color(mainColor))),
    ),
  ];
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  final screens = [
    const VendorHomePage(),
    const VendorOrderPage(),
    const VendorAccountPage(),
    const VendorSettingsPage()
  ];

  List<BottomNavyBarItem> navBarsItems() => pages;

  List<Widget> buildScreens() => screens;

  final selectedPagesIndex = 0.obs;

  void routerOutlet(int index) {
    selectedPagesIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> getSolde() async {
    loading.value = false;
    try {
      double? solde = await _clientService.solde();
      print("SOLDE $solde");
      if (solde != null) {
        this.solde.value = solde.toInt();
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
