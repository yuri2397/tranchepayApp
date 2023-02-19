import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/core/provider/order.provider.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class OrderService extends GetxService {
  static final _provider = OrderProvider();
  Future<OrderService> init() async {
    return this;
  }

  Future<Client?> index({params}) async {
    try {
      final response = await _provider.index(params: params);
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
}
