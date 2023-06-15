import 'dart:convert';

import 'package:tranchepay_mobile/app/models/commande.model.dart';
import 'package:tranchepay_mobile/app/models/compte.model.dart';

List<Retrait> retraitFromJson(String str) =>
    List<Retrait>.from(json.decode(str).map((x) => Retrait.fromJson(x)));

String retraitToJson(List<Retrait> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Retrait {
  Retrait(
      {this.id,
      this.date,
      this.via,
      this.reference,
      this.montant,
      this.compteId,
      this.createdAt,
      this.updatedAt,
      this.compte,
      this.description});

  String? id;
  DateTime? date;
  String? via;
  String? reference;
  String? description;
  double? montant;
  String? compteId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Compte? compte;

  factory Retrait.fromJson(Map<String, dynamic> json) => Retrait(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date_time"]),
        via: json["via"],
        reference: json["reference"],
        description: json["description"],
        montant: json["montant"],
        compteId: json["compte_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        compte: json["compte"] == null ? null : Compte.fromJson(json["compte"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": date?.toIso8601String(),
        "via": via,
        "reference": reference,
        "description": description,
        "montant": montant,
        "compte_id": compteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "compte": compte?.toJson(),
      };
}
