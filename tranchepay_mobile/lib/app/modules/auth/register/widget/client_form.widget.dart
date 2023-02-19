import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
        TextFormField(
          style: TextStyle(color: Color(mainColor), fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Prénom',
            hintStyle: TextStyle(color: Color(mainColor), fontSize: 16),
            prefixIcon: Icon(
              Icons.person,
              color: Color(mainColor),
              size: 30,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(mainColor)),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre prénom';
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
            prefixIcon: Icon(
              Icons.person,
              color: Color(mainColor),
              size: 30,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(mainColor)),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir votre nom';
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
            prefixIcon: Icon(
              Icons.phone_android_outlined,
              color: Color(mainColor),
              size: 30,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(mainColor)),
            ),
          ),
          inputFormatters: [
            UpperCaseTextFormatter(),
            MaskTextInputFormatter(
                mask: '+221 ## ### ## ##', filter: {"#": RegExp(r'[0-9]')})
          ],
          keyboardType: TextInputType.phone,
          onChanged: (value) => controller.client.value.telephone = value,
        ).marginOnly(bottom: 40),
        SizedBox(
          width: Get.width,
          child: PrimaryButton(
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
    );
  }
}
