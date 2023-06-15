import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commercant.model.dart';
import 'package:tranchepay_mobile/app/models/compte.model.dart';
import 'package:tranchepay_mobile/core/utils/helpers.dart';

import '../../../models/boutique.model.dart';

class VendorHomeController extends GetxController {
  final vendor = Commercant().obs;
  final boutique = Boutique().obs;
  final solde = (0.0).obs;

  @override
  void onInit() async{
    vendor.value = Commercant.fromJson(localStorage.getVendor()!);
    boutique.value = Boutique.fromJson(localStorage.getVendorBoutique()!);
  }

}