import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_order_history.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_order_card_item.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class ClientOrderHistoryWidget extends GetView<ClientOrderHistoryController> {
  const ClientOrderHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
            backgroundColor: Color(neutralColor),
            body: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/icons/avatar.jpg'),
                        ),
                      ),
                    ),
                  ).marginOnly(right: 5),
                  Expanded(
                    child: Text("HISTORIQUE DES COMMANDES",
                            style: Get.textTheme.headline5
                                ?.merge(TextStyle(color: Color(mainColor))))
                        .marginOnly(left: 10),
                  ),
                ]).marginAll(10),
                controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: const WaterDropHeader(
                            refresh: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                            complete: Text(
                              "Chargement terminé",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          footer: CustomFooter(builder: (_, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.loading) {
                              body = CircularProgressIndicator(
                                color: Color(mainColor),
                                strokeWidth: 2,
                              );
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Load Failed!Click retry!");
                            } else if (mode == LoadStatus.canLoading) {
                              body = const Text("Relâcher pour charger plus");
                            } else {
                              body = Container();
                            }
                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          }),
                          controller: controller.refreshController,
                          onRefresh: controller.onRefresh,
                          onLoading: controller.onLoading,
                          child: ListView.builder(
                            itemCount: controller.orders.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) =>
                                ClientOrderCardItem(
                                        order: controller.orders[index])
                                    .marginOnly(bottom: 20),
                          ),
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}
