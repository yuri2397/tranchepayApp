import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class HomeGreyCard extends Container{
  String title;
  IconData icon;
  HomeGreyCard({super.key, required this.title, required this.icon}):super(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(neutralColor),
    ),
    width: Get.width,
    height: 120,
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Color(mainColor)).marginOnly(bottom: 3),
        Text(title, style: TextStyle(
          color: Color(mainColor),
          fontFamily: 'Poppins'
        ), textAlign: TextAlign.center,)
      ],
    )
  );
}