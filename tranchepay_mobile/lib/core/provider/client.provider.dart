import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

class ClientProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> setProfileData(
          {required String firstName,
          required String lastName,
          required String address,
          required String phone,
          String? email}) async =>
      _client.post('/auth/register', data: {
        'email': email,
        'phone': phone,
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
      });

  Future<dio.Response> registerClient(Client client, String password) async {
    return _client.post('client', data: {
      'prenoms': client.prenoms,
      'nom': client.nom,
      'telephone': client.telephone,
      'adresse': client.adresse,
      'password': password
    });
  }

  Future<dio.Response> versements({params}) async {
    return _client.get('/client/versements', params: params);
  }

  Future<dio.Response> solde() async {
    return _client.get('/client/solde');
  }

  Future<dio.Response> commandes({params}) async {
    return _client.get('/client/commandes', params: params);
  }

  Future<dio.Response> findUser(String phoneNumber) async {
    return _client.get('/client/check', params: {'phone_number': phoneNumber});
  }

  Future<dio.Response> detailsCommande(String commandeId, {required params}) {
    return _client.get('/client/commandes/$commandeId/details', params: params);
  }

  Future<dio.Response> detailsPayment(String versementId, {required params}) {
    return _client.get('/client/versements/$versementId/details',
        params: params);
  }
}
