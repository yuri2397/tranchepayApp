import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme.colors.dart';

class TextGroupWidget extends Container{
  String title;
  String subTitle;
  TextGroupWidget({super.key,required this.title,required this.subTitle}): super(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 16,fontWeight: FontWeight.w500, color: Color(mainColor)),).marginOnly(bottom: 5),
        Text(subTitle, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.black,),)
      ],
    )
  );

}