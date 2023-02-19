import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tranchepay_mobile/app/models/shared.model.dart';

class LocalStorageService extends GetxService {
  late GetStorage _box;

  LocalStorageService() {
    _box = GetStorage();
  }

  void setToken(String token) {
    _box.write('token', token);
  }

  String? getToken() {
    return _box.read('token');
  }

  void removeToken() {
    _box.remove('token');
  }

  // set fcm_token
  void setPassword(String password) {
    _box.write('password', password);
  }

  String? getPassword() {
    return _box.read('password');
  }

  // set fcm_token
  void setFcmToken(String token) {
    _box.write('fcm_token', token);
  }

  String? getFcmToken() {
    return _box.read('fcm_token');
  }

  void removePassword() {
    _box.remove('password');
  }

  // is logged
  void setIsLogged(bool isLogged) {
    _box.write('isLogged', isLogged);
  }

  bool getIsLogged() {
    return _box.read('isLogged') != null && _box.read('isLogged') == true;
  }

  void removeIsLogged() {
    _box.remove('isLogged');
  }

  // set user

  void setUser(Map<String, dynamic> user) {
    _box.write('user', user);
  }

  Map<String, dynamic>? getUser() {
    return _box.read('user');
  }

  void removeUser() {
    _box.remove('user');
  }

  void setUserType(String type) {
    _box.write('userType', type);
  }

  String getUserType() {
    return _box.read('userType') == "App\\Models\\Client" ? 'client' : 'vendor';
  }

  // client

  void setClient(Map<String, dynamic> client) {
    _box.write('client', client);
  }

  Map<String, dynamic>? getClient() {
    return _box.read('client');
  }

  void removeClient() {
    _box.remove('client');
  }

  int? getSolde() {
    return _box.read('solde');
  }

  void setSolde(int solde) {
    _box.write('solde', solde);
  }

  void removeSolde() {
    _box.remove('solde');
  }

  void clear() {
    _box.erase();
  }

  // vendor

}
