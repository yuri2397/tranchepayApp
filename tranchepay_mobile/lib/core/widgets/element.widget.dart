import 'package:flutter/material.dart';
import 'package:tranchepay_mobile/core/ui.dart';

class AddUserAvatarButton extends Container {
  VoidCallback? onPressed;
  AddUserAvatarButton({super.key, this.onPressed})
      : super(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: Ui.parseColorText("#B6B6B6"),
        radius: 70,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_rounded,
                size: 50,
                color: Colors.white,
              ),
              Text(
                "Ajouter une photo",
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            ]),
      ),
    );
  }
}
