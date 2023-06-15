import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:tranchepay_mobile/app/models/produit.model.dart';
import 'package:tranchepay_mobile/app/modules/vendor/controller/add_order.controller.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

import '../../../views/shared/payment/payment.widget.dart';

class AddOrderPage extends GetView<AddOrderController> {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child:
                          Icon(Icons.arrow_back_ios, color: Color(mainColor))),
                  Text("Ajouter une commande".toUpperCase(),
                          style: Get.textTheme.headline5
                              ?.merge(TextStyle(color: Color(mainColor))))
                      .marginOnly(left: 10),
                  GestureDetector(
                          onTap: () {
                            Get.bottomSheet(_addProductForm());
                          },
                          child: Icon(Icons.add_shopping_cart_rounded,
                              size: 30, color: Color(mainColor)))
                      .marginOnly(right: 10),
                ],
              ).paddingAll(10),
            ),
          ),
          //listview of products
          body: Column(
            children: [
              Container(
                height: 140,
                width: Get.width,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                decoration: BoxDecoration(
                    color: Color(neutralColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "TOTAL   ${MoneyFormatter(amount: (controller.total), settings: MoneyFormatterSettings(symbol: "CFA", fractionDigits: 0, decimalSeparator: ",", thousandSeparator: '.')).output.symbolOnRight}",
                          style: Get.textTheme.headline5
                              ?.merge(TextStyle(color: Color(mainColor)))),
                      PrimaryButton(
                          elevation: 0,
                          onPressed: controller.products.isEmpty
                              ? null
                              : () => Get.bottomSheet(__chooseModePayment()),
                          child: Text(
                            "Valider la commande".toUpperCase(),
                            style: TextStyle(
                                color: Color(mainColor),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ))
                    ]).paddingAll(10),
              ),
              controller.products.isEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.asset("assets/images/empty_cart.jpg",
                              height: 150),
                        ).marginOnly(bottom: 30),
                        Text("Aucun produit ajouté",
                            style: Get.textTheme.headline5
                                ?.merge(TextStyle(color: Color(mainColor))))
                      ],
                    ).marginSymmetric(horizontal: 30, vertical: 30)
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Panier client",
                                  style: Get.textTheme.headline6)
                              .marginOnly(bottom: 10, top: 30),
                          ListView.builder(
                            itemCount: controller.products.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ListTile(
                                title: Text("${controller.products[index].nom}",
                                    style: Get.textTheme.headline5),
                                subtitle: Text(
                                  MoneyFormatter(
                                          amount: (controller.products[index]
                                                      .quantite! *
                                                  controller.products[index]
                                                      .prixUnitaire!)
                                              .toDouble(),
                                          settings: MoneyFormatterSettings(
                                              symbol: "CFA",
                                              fractionDigits: 0,
                                              decimalSeparator: ",",
                                              thousandSeparator: '.'))
                                      .output
                                      .symbolOnRight,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(darkColor)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      controller.products.removeAt(index);
                                    },
                                    icon: Icon(Icons.delete,
                                        color: Color(mainColor)))),
                          ),
                          // sliding up panel
                        ],
                      ),
                    )
            ],
          )),
    );
  }


  Widget _addProductForm() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // mini bar grey
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  color: Color(neutralColor),
                  borderRadius: BorderRadius.circular(10)),
            ),
            TextFormField(
              style: TextStyle(
                color: Color(mainColor),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: "Nom du produit",
                labelStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (value) {
                controller.currentProduct.value.nom = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Le nom du produit est requis";
                }
                return null;
              },
              onSaved: (value) {
                controller.currentProduct.value.nom = value;
              },
            ),
            TextFormField(
              style: TextStyle(
                color: Color(mainColor),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: "Prix unitaire",
                labelStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                suffix: Text("FCFA",
                    style: TextStyle(
                      color: Color(mainColor),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "Le prix unitaire est requis";
                }
                return null;
              },
              onChanged: (value) => controller.currentProduct.value
                  .prixUnitaire = double.parse(value).toInt(),
              onSaved: (value) {
                controller.currentProduct.value.prixUnitaire =
                    double.parse(value!).toInt();
              },
            ),
            TextFormField(
              style: TextStyle(
                color: Color(mainColor),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: "Quantité",
                labelStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "La quantité est requise";
                }
                return null;
              },
              onChanged: (value) =>
                  controller.currentProduct.value.quantite = int.parse(value),
              onSaved: (value) {
                controller.currentProduct.value.quantite = int.parse(value!);
              },
            ).marginOnly(bottom: 30),
            SizedBox(
              width: Get.width,
              child: PrimaryButton(
                elevation: 0,
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    Get.log("ADD PRODUCT");
                    controller.products
                        .add(controller.currentProduct.value.copyWith());
                    controller.currentProduct.value = Produit();
                    controller.products.refresh();
                    Get.log("PRODUCTS: ${controller.products.length}");
                    Get.back();
                  }
                },
                child: Text("Ajouter au panier", style: Get.textTheme.button),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget __chooseModePayment() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // mini bar grey
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
                color: Color(neutralColor),
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Premiere tranche",
                      style: Get.textTheme.headline6
                          ?.merge(TextStyle(color: Color(mainColor))))
                  .marginOnly(left: 30),
            ],
          ).marginOnly(bottom: 20),
          PaymentWidget().marginSymmetric(horizontal: 25)
        ],
      ),
    );
  }
}
