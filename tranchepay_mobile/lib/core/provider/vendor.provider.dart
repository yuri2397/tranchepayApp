import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/core/provider/base/api_client.dart';
import 'package:dio/dio.dart' as dio;

import '../../app/models/boutique.model.dart';

class VendorProvider {
  final _client = Get.find<ApiClient>();

  Future<dio.Response> addBoutique({required Boutique boutique, XFile? file}) async {
    dio.FormData formData = dio.FormData.fromMap(boutique.toJson());

    if (file != null) {
      formData.files.add(
        MapEntry('logo', await dio.MultipartFile.fromFile(file.path)),
      );
    }
    return _client.post('/boutiques', data: formData, options: dio.Options(contentType: 'multipart/form-data'));
  }

  Future<dio.Response> show({required String id,  Map<String, dynamic>? params}) async {
    return _client.get('/commercants/$id', params: params, );
  }
}
