import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/services/settings.service.dart';

mixin BaseApiClient {
  final settingsService = Get.find<SettingService>();
  late String baseUrl;

  String getBaseUrl(String path) {
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!baseUrl.endsWith('/')) {
      return '$baseUrl/$path';
    }
    return baseUrl + path;
  }

  String getApiBaseUrl(String path) {
    if (path.startsWith('/')) {
      return getBaseUrl(path.substring(1));
    }
    return getBaseUrl(path);
  }

  Uri getApiBaseUri(String path) {
    return Uri.parse(getApiBaseUrl(path));
  }

  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(stackTrace.toString());
  }
}
