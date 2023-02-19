import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/core/helper.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class InputPhoneNumberWidget extends StatelessWidget {
  const InputPhoneNumberWidget(
      {super.key,
      required this.formatter,
      this.validator,
      required this.hint,
      required this.onChanged,
      this.onValide,
      required this.textInputType,
      required this.textController});

  final TextEditingController textController;
  final MaskTextInputFormatter formatter;
  final FormFieldValidator<String>? validator;
  final String hint;
  final TextInputType textInputType;
  final Function onChanged;
  final Function? onValide;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: true,
        style: TextStyle(
            color: Color(mainColor),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        controller: textController,
        inputFormatters: [const UpperCaseTextFormatter(), formatter],
        autocorrect: false,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.always,
        validator: validator,
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white.withOpacity(0.5),
            filled: true,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(mainColor))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(neutralColor))),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(mainColor))),
            errorMaxLines: 1));
  }
}
