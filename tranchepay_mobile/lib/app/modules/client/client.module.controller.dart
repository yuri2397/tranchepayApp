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
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientModuleController extends GetxController {
  final _clientService = Get.find<ClientService>();
  final solde = 0.obs;

  final _storage = Get.find<LocalStorageService>();
  final loading = true.obs;

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  final _pages = <BottomNavyBarItem>[
    BottomNavyBarItem(
        activeColor: Colors.white,
        icon: SvgPicture.asset("assets/icons/b_1.svg", width: 20),
        title: const Text("ACCUEIL", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12))),
    BottomNavyBarItem(
        activeColor: Colors.white,
        icon: SvgPicture.asset("assets/icons/b_2.svg", width: 20),
        title: const Text("COMMANDES", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12))),
    BottomNavyBarItem(
        activeColor: Colors.white,
        icon: SvgPicture.asset("assets/icons/b_3.svg", width: 20),
        title:const  Text("PAIMENTS", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12))),
    BottomNavyBarItem(
      activeColor: Colors.white,
      icon: SvgPicture.asset("assets/icons/b_4.svg", width: 20,),
      title:const Text("PARAMETRES", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12)),
    ),
  ];

  final screens = [
    const ClientProfilePage(),
    const ClientOrderHistoryWidget(),
    const ClientPaymentPage(),
    const ClientSettingsPage()
  ];

  List<BottomNavyBarItem> navBarsItems() => _pages;

  List<Widget> buildScreens() => screens;

  final selectedPagesIndex = 0.obs;

  void routerOutlet(int index) {
    selectedPagesIndex.value = index;
  }

  @override
  void onInit() async {
     getSolde();
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
