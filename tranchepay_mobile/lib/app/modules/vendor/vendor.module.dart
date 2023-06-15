import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/modules/vendor/vendor_module.controller.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class VendorModule extends GetView<VendorModuleController> {
  const VendorModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx( () => Scaffold(
        bottomNavigationBar: BottomNavyBar(
          showElevation: true,
          selectedIndex: controller.selectedPagesIndex.value,
          items: controller.pages,
          animationDuration: const Duration(milliseconds: 300),
          onItemSelected: (index) => controller.routerOutlet(index),
          backgroundColor: Color(primaryColor),
        ),
        body: Container(
            color: Colors.white,
            child: controller.screens[controller.selectedPagesIndex.value]),
      ),
    );
  }
}
