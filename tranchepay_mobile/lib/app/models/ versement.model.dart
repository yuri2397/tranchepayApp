import 'dart:convert';

import 'package:tranchepay_mobile/app/models/commande.model.dart';

List<Versement> versementFromJson(String str) =>
    List<Versement>.from(json.decode(str).map((x) => Versement.fromJson(x)));

String versementToJson(List<Versement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Versement {
  Versement({
    this.id,
    this.dateTime,
    this.via,
    this.reference,
    this.montant,
    this.commandeId,
    this.createdAt,
    this.updatedAt,
    this.commande,
  });

  String? id;
  DateTime? dateTime;
  String? via;
  String? reference;
  int? montant;
  String? commandeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Commande? commande;

  factory Versement.fromJson(Map<String, dynamic> json) => Versement(
        id: json["id"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        via: json["via"],
        reference: json["reference"],
        montant: json["montant"],
        commandeId: json["commande_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        commande: json["commande"] == null
            ? null
            : Commande.fromJson(json["commande"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "via": via,
        "reference": reference,
        "montant": montant,
        "commande_id": commandeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "commande": commande?.toJson(),
      };
}
