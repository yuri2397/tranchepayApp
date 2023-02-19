import 'package:get/state_manager.dart';
import 'package:tranchepay_mobile/app/models/wave_payment.model.dart';
import 'package:tranchepay_mobile/core/provider/payement.provider.dart';

class PaymentService extends GetxService {
  final _provider = PaymentProvider();

  Future<WavePaymentResponse?> wave(
      {required double amount,
      required String phone,
      required String commandeId}) async {
    try {
      var response = await _provider.wave(
          amount: amount, phone: phone, commandeId: commandeId);

      if (response.statusCode == 200) {
        return WavePaymentResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("WAVE PAYEMENT ERROR: $e");
      return null;
    }
  }
}
