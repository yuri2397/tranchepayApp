import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/retrait.model.dart';
import 'package:tranchepay_mobile/core/provider/retrait.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class RetraitService extends GetxService {
  static final _provider = RetraitProvider();
  Future<RetraitService> init() async {
    return this;
  }

  Future<List<Retrait>?> store({Map<String, dynamic>? params}) async {
    try {
      final response = await _provider.index(params: params);
      if (response.statusCode == 200) {
        if (params != null && params.containsKey('per_page')) {
          return List<Retrait>.from(
              response.data['data'].map((x) => Commande.fromJson(x)));
        } else {
          return List<Retrait>.from(
              response.data.map((x) => Commande.fromJson(x)));
        }
      }
      Ui.errorMessage(message: "Une erreur est survenue");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
