import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/register.controller.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/widgets/button.widget.dart';

class ClientFormWidget extends GetView<RegisterController> {
  ClientFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.clientFormKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Color(mainColor), fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Prénom',
              hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(mainColor)),
              ),
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Veuillez saisir votre prénom';
              }else if (value != null && value.length < 2){
                return 'Veuillez saisir un prénom correct';
              }
              return null;
            },
            onChanged: (value) => controller.client.value.prenoms = value,
          ).marginOnly(bottom: 20),
          TextFormField(
            style: TextStyle(color: Color(mainColor), fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Nom',
              hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(mainColor)),
              ),
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Veuillez saisir votre nom';
              }else if (value != null && value.length < 2){
                return 'Veuillez saisir un nom correct';
              }
              return null;
            },
            onChanged: (value) => controller.client.value.nom = value,
          ).marginOnly(bottom: 20),
          TextFormField(
            style: TextStyle(color: Color(mainColor), fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Téléphone',
              hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(mainColor)),
              ),
            ),
            inputFormatters: [
              const UpperCaseTextFormatter(),
              MaskTextInputFormatter(
                  mask: '+221 ## ### ## ##', filter: {"#": RegExp(r'\d')}),
            ],
            keyboardType: TextInputType.phone,
            onChanged: (value) => controller.client.value.telephone = value,
          ).marginOnly(bottom: 40),
          SizedBox(
            width: Get.width,
            child: PrimaryButton(
              elevation: 0,
              onPressed: () async => controller.validateClientForm(),
              child: Text(
                'Suivant'.toUpperCase(),
                style: TextStyle(
                    color: Color(mainColor),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
