import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/partener.model.dart';
import 'package:tranchepay_mobile/app/services/local_storage.service.dart';
import 'package:tranchepay_mobile/core/provider/shared.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class SharedService extends GetxService {
  static final _provider = SharedProvider();
  Future<SharedService> init() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    setFcmToken(fcmToken!);
    return this;
  }

  Future<List<Partener>?> parteners({Map<String, dynamic>? params}) async {
    try {
      final response = await _provider.parteners(params: params);
      print("response: $response");
      if (response.statusCode == 200) {
        if (params != null && params.containsKey("per_page")) {
          return partenerFromJson(response.data['data'].toString());
        }
        return partenerFromJson(response.data.toString());
      }

      Ui.errorMessage(message: "Une erreur est survenue");
      return null;
    } catch (e) {
      print("[SharedService]: (parteners) => $e");
      return null;
    }
  }

  setFcmToken(String token) {
    Get.find<LocalStorageService>().setFcmToken(token);
  }
}
