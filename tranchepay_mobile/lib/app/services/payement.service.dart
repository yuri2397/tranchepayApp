import 'package:get/state_manager.dart';
import 'package:tranchepay_mobile/app/models/om_payment_response.model.dart';
import 'package:tranchepay_mobile/app/models/padding.model.dart';
import 'package:tranchepay_mobile/app/models/wave_payment.model.dart';
import 'package:tranchepay_mobile/core/provider/payement.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class PaymentService extends GetxService {
  final _provider = PaymentProvider();

  Future<WavePaymentResponse?> wave(
      {required double amount,
      required String phone,
      required String commandeId}) async {
    Get.log("wave");
    try {
      var response = await _provider.wave(
          amount: amount, phone: phone, commandeId: commandeId);
      print(response);
      if (response.statusCode == 200) {
        return WavePaymentResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<OmPaymentResponse?> om(
      {required double amount,
      required String phone,
      required String commandeId}) async {
    try {
      var response = await _provider.om(amount: amount, phone: phone, commandeId: commandeId);
      print(response);
      if (response.statusCode == 200) {
        return OmPaymentResponse.fromJson(response.data);
      } else if (response.statusCode == 422) {
        Ui.errorMessage(message: response.data['message']);
      }

      return null;
    } catch (e) {
      print("OM PAYEMENT ERROR: $e");
      return null;
    }
  }

  Future<bool> checkPayment(String paddingId)async {
    try {
      var response = await _provider.checkPayment(paddingId);
      print(response);
      if(response.statusCode == 200){
        var data = Padding.fromJson(response.data);
        return data.status != 0;
      }
    return false;
    } catch (e) {
      print("CHECK: $e");
      return false;
    }
  }


}
