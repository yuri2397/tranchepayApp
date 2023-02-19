import 'dart:convert' as convert;
import 'dart:io' as io;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/etat_commande.model.dart';
import 'package:tranchepay_mobile/core/widgets/tag.widget.dart';

import 'ui.dart';

class Helper {
  late DateTime currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

class SpecialMaskTextInputFormatter extends MaskTextInputFormatter {
  static String maskA = "S.####";
  static String maskB = "S.######";

  SpecialMaskTextInputFormatter({String? initialText})
      : super(
            mask: maskA,
            filter: {"#": RegExp('[0-9]'), "S": RegExp('[AB]')},
            initialText: initialText);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith("A")) {
      if (getMask() != maskA) {
        updateMask(mask: maskA);
      }
    } else {
      if (getMask() != maskB) {
        updateMask(mask: maskB);
      }
    }
    return super.formatEditUpdate(oldValue, newValue);
  }
}

String formatDate({required DateTime date, String? format = 'dd/MM/yyyy'}) {
  return DateFormat(format).format(date);
}

double alreadyPaid(Commande order) {
  double paid = 0;
  for (var v in order.versements!) {
    paid += v.montant!;
  }
  return paid;
}

double restForPaid(Commande order) {
  return (order.prixTotal! + order.commission!) - alreadyPaid(order);
}

TagType etatCommandeType(EtatCommande etatCommande) {
  switch (etatCommande.nom) {
    case 'load':
      return TagType.warning;

    case 'append':
      return TagType.primary;

    case 'finish':
      return TagType.success;

    case 'cancel':
      return TagType.danger;
    default:
      return TagType.primary;
  }
}

String etatCommandeText(EtatCommande etatCommande) {
  switch (etatCommande.nom) {
    case 'load':
      return 'EN COURS';

    case 'append':
      return 'EN ATTENTE';

    case 'finish':
      return 'TERMINER';

    case 'cancel':
      return 'ANNULER';
    default:
      return 'INDEFINIE';
  }
}
