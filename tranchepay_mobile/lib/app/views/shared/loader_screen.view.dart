import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';

class LoaderScreen extends StatelessWidget {
  String? message;
  String? paragraph;
  bool? loading;
  LoaderScreen({super.key, this.message, this.paragraph, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/icons/bag.svg"),
              const SizedBox(height: 20),
              Text(
                "$message",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "$paragraph",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              if (loading!) const SizedBox(height: 100),
              if (loading!)
                SizedBox(
                    width: Get.width * .5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(accentColor)),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
