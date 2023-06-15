import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/vendor_settings.controller.dart';

class VendorSettingsPage extends GetView<VendorSettingsController>{
  const VendorSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VendorHomePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'settings is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}