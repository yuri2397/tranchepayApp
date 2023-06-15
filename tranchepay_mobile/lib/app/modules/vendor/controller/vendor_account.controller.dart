import 'package:get/get.dart';

import '../../../../core/utils/helpers.dart';
import '../../../models/boutique.model.dart';
import '../../../models/commercant.model.dart';

class VendorAccountController extends GetxController {
  final solde = (0.0).obs;
  final vendor = Commercant().obs;
  final boutique = Boutique().obs;

  @override
  void onInit() async{
    vendor.value = Commercant.fromJson(localStorage.getVendor()!);
    boutique.value = Boutique.fromJson(localStorage.getVendorBoutique()!);
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async{

  }
}