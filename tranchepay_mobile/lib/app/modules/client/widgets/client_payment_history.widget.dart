import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/client/controller/client_payment_history.controller.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_card_item.dart';
import 'package:tranchepay_mobile/app/views/shared/empty_list.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class ClientPaymentHistoryWidget
    extends GetView<ClientPaymentHistoryController> {
  const ClientPaymentHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : controller.payments.isEmpty
            ? EmptyList()
            : Container(
                height: Get.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Ui.parseColor("#EDEDED"),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset:
                          const Offset(0.5, .5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('HISTORIQUE',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(mainColor))),

                    ),
                    ListView.separated(
                      itemCount: controller.payments.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ClientPaymentCardItem(
                          payment: controller.payments[index]),
                      separatorBuilder: (BuildContext context, int index) {
                        if (index != controller.payments.length - 1) {
                          return Container(
                            height: 1,
                            color: Colors.grey[300],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ));
  }
}
