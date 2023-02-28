import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.controller.dart';
import 'package:tranchepay_mobile/app/services/client.service.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/ui.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class ClientOrderDetailController extends GetxController {
  final solde = Get.find<ClientModuleController>().solde.obs;
  final _clientService = Get.find<ClientService>();
  final order = Commande().obs;
  final hasError = false.obs;
  final loading = true.obs;

  @override
  void onInit() async {
    await findOrderDetails();
    super.onInit();
  }

  Future<void> findOrderDetails() async {
    loading.value = true;
    hasError.value = false;

    try {
      var response = await _clientService
          .detailsCommande(Get.parameters['order_id']!, params: {
        'with[]': ['produits', 'boutique', 'versements']
      });
      if (response != null) {
        order.value = response;
      } else {
        Ui.errorMessage(message: 'Vérifier votre connexion.', title: 'Erreur');
        hasError.value = true;
      }
    } catch (e) {
      print(e);
    } finally {
      hasError.value = true;

      loading.value = false;
    }
  }

  Future<void> makePayment() async {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0.5, .5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 80,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ).marginSymmetric(vertical: 5).marginOnly(bottom: 20),
              ),
              Text("Faire un versement",
                      style: TextStyle(
                          color: Color(mainColor),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                  .marginOnly(bottom: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Color(mainColor),
                cursorHeight: 20,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.payment_outlined,
                      color: Colors.black,
                    ),
                    hintText: 'Montant versement',
                    hintStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder()),
              ).marginOnly(bottom: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: Color(mainColor),
                cursorHeight: 20,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    hintText: 'Numéro de téléphone',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder()),
              ).marginOnly(bottom: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/wave.jpg"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/om.jpg"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/free.jpg"),
                    ),
                  )
                ],
              ).marginOnly(bottom: 30),
              SizedBox(
                width: Get.width,
                child: PrimaryButton(
                    onPressed: () {},
                    child: Text("VALIDER",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(mainColor),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }


}
