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
              SvgPicture.asset(
                "assets/icons/bag.svg",
                width: 80,
              ),
              const SizedBox(height: 10),
              Text(
                "$message",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 10),
              paragraph != null
                  ? Text(
                      "$paragraph",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    )
                  : Container(),
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
