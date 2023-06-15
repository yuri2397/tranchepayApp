import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';
import 'package:tranchepay_mobile/core/theme.colors.dart';
import 'package:tranchepay_mobile/core/utils/helpers.dart';

class FirstTimeInstall extends StatefulWidget {
  FirstTimeInstall({super.key});

  @override
  State<FirstTimeInstall> createState() => _FirstTimeInstallState();
}

class _FirstTimeInstallState extends State<FirstTimeInstall> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      titleWidget: const Text("Achetez maintenant, payez plus tard avec TranchPay", style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w600
      ), textAlign: TextAlign.center,),
      bodyWidget: const Text("Avec TranchPay, vous pouvez acheter des produits en ligne dès maintenant et payer plus tard en plusieurs fois.",
      style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      image: CircleAvatar(radius: 80, backgroundColor: Color(neutralColor), child:  Image.asset("assets/images/img.png", height: 140),),
    ),
    PageViewModel(
      titleWidget: const Text("Paiements instantanés pour les commerçants", style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600
      ), textAlign: TextAlign.center,),
      bodyWidget: const Text("TranchPay offre un système de paiement instantané pour les commerçants, leur permettant de recevoir l'intégralité du montant de la commande dès qu'elle est validée.",
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      image: CircleAvatar(radius: 80, backgroundColor: Color(neutralColor), child:  Image.asset("assets/images/img.png", height: 140)),
    ),
    PageViewModel(
      titleWidget: const Text(" Options de paiement pratiques avec TranchPay", style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600
      ), textAlign: TextAlign.center,),
      bodyWidget: const Text("TranchPay offre une variété d'options de paiement pour rendre le processus de paiement encore plus pratique et accessible pour vous. Nous acceptons les paiements mobiles tels que Wave, Orange Money et Free Money.",
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      image: CircleAvatar(radius: 80, backgroundColor: Color(neutralColor), child:  Image.asset("assets/images/img.png", height: 140),),
    ),
    PageViewModel(
      titleWidget: const Text(" Sécurité et simplicité avec TranchPay", style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600
      ), textAlign: TextAlign.center,),
      bodyWidget: const Text("Chez TranchPay, nous croyons en une expérience de paiement facile et sécurisée pour tous. Notre processus de paiement est simple et sécurisé, vous offrant la tranquillité d'esprit que vos informations de paiement sont protégées.",
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
      image: CircleAvatar(radius: 80, backgroundColor: Color(neutralColor), child:  Image.asset("assets/images/img.png", height: 140),),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IntroductionScreen(
            pages: listPagesViewModel,
            showBackButton: false,
            showNextButton: false,
            globalBackgroundColor: Colors.white,
            done: const Icon(Icons.arrow_forward_ios_rounded),
            onDone: () {
              localStorage.setFirstTimeInstall(true);
              Get.offAllNamed(AppRoutes.loginNumber);
            },
          ),
        ));
  }
}
