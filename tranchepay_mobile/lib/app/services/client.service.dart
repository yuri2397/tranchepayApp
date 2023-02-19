import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/core/provider/client.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientService extends GetxService {
  static final _provider = ClientProvider();
  Future<ClientService> init() async {
    return this;
  }

  Future<Client?> store(Client client, String password) async {
    try {
      final response = await _provider.registerClient(client, password);
      print("response: $response");
      if (response.statusCode == 200) {
        return Client.fromJson(response.data);
      }
      Ui.errorMessage(message: "Une erreur est survenue");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Commande>?> commandes({Map<String, dynamic>? params}) async {
    try {
      var response = await _provider.commandes(params: params);
      print(response);
      if (response.statusCode == 200) {
        if (params != null && params.containsKey('per_page')) {
          return List<Commande>.from(
              response.data['data'].map((x) => Commande.fromJson(x)));
        } else {
          return List<Commande>.from(
              response.data.map((x) => Commande.fromJson(x)));
        }
      }
      return [];
    } catch (e) {
      print('ERRRRRRR: $e');
      rethrow;
    }
  }

  Future<Commande?> detailsCommande(String commandeId, {params}) async {
    try {
      var response =
          await _provider.detailsCommande(commandeId, params: params);

      if (response.statusCode == 200) {
        return Commande.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('ERRRRRRR: $e');
      rethrow;
    }
  }

  Future<Versement?> detailsPayment(String paymentId, {params}) async {
    try {
      var response = await _provider.detailsPayment(paymentId, params: params);

      if (response.statusCode == 200) {
        return Versement.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('ERRRRRRR: $e');
      rethrow;
    }
  }

  Future<List<Versement>?> versements({params}) async {
    try {
      var response = await _provider.versements(params: params);
      if (response.statusCode == 200) {
        return List<Versement>.from(
            response.data.map((x) => Versement.fromJson(x)));
      }
      return [];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int?> solde() async {
    try {
      var response = await _provider.solde();
      print(response.data);
      if (response.statusCode == 200) {
        Get.log("parse");
        return int.tryParse(response.data);
      }
      return 0;
    } catch (e) {
      print('SOLDE: $e');
      rethrow;
    }
  }

  // Future<Client> findUser(String phoneNumber) async {
  //   try {
  //     var response = _provider.findUser(phoneNumber);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
