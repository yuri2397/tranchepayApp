import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/ui.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

void callPhone(String? phone) async {
  if (phone == null) {
    Ui.errorMessage(message: "Numéro de téléphone indisponible.");
    return;
  }
  canLaunchUrl(Uri(scheme: 'tel', path: phone.replaceAll(" ", "")))
      .then((result) async {
    if (result) {
      await launchUrl(Uri(scheme: 'tel', path: phone));
    }
  });
}
