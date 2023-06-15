import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/commercant.model.dart';
import 'package:tranchepay_mobile/app/services/order.service.dart';

import '../../../../core/utils/helpers.dart';
import '../../../models/boutique.model.dart';

class VendorOrderController extends GetxController {
  final orderService = Get.find<OrderService>();
  final orders = <Commande>[].obs;
  final loading = false.obs;
  final vendor = Commercant().obs;
  final boutique = Boutique().obs;

  void onInit() async{
    Get.log("VENDOR_ORDER_CONTROLLER INIT");
    vendor.value = Commercant.fromJson(localStorage.getVendor()!);
    boutique.value = Boutique.fromJson(localStorage.getVendorBoutique()!);
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async{
    loading.value = true;
    try{
      var response = await orderService.index(params: {
        'per_page': '20'
      });
      print(response);
     if(response != null){
       orders.value = response;
     }
    }catch(e){
     print(e);
    }finally{
      loading.value = false;
    }
  }
}