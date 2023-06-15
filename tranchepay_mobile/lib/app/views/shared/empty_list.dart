import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyList extends Container{
  String message = "Aucune transaction trouvées";
  EmptyList({super.key, this.message = "Aucune transactions trouvées"}):super(
    child: SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty_box.png", width: 50,).marginOnly(bottom: 10),
          const Text("Aucune transaction trouvées.", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black))
        ],
      ),
    )
  );

}