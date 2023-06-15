import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/app/models/boutique.model.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/commercant.model.dart';
import 'package:tranchepay_mobile/core/provider/client.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/utils/helpers.dart';

import '../../core/provider/vendor.provider.dart';

class VendorService extends GetxService {
  static final _provider = VendorProvider();
  Future<VendorService> init() async {
    return this;
  }

  Future<Boutique?> addBoutique({required Boutique boutique, XFile? file}) async {
    try {
      final response = await _provider.addBoutique(boutique: boutique, file:file);
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var data =  Boutique.fromJson(response.data['boutique']);
        localStorage.setVendorBoutique(data.toJson());
        return data;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Commercant?> show({required String id, Map<String, dynamic>? params}) async {
    try {
      final response = await _provider.show(id: id, params: params);
      print("show commercant: ${response.data}");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Commercant.fromJson(response.data);
      }
      Ui.errorMessage(message: "Une erreur est survenue");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
