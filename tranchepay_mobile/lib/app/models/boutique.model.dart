import 'package:tranchepay_mobile/app/models/compte.model.dart';

class Boutique {
  Boutique({
    this.id,
    this.nom,
    this.addresse,
    this.commercantId,
    this.createdAt,
    this.updatedAt,
    this.compte,
  });

  String? id;
  String? nom;
  String? addresse;
  String? commercantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Compte? compte;

  factory Boutique.fromJson(Map<String, dynamic> json) => Boutique(
        id: json["id"],
        nom: json["nom"],
        addresse: json["addresse"],
        commercantId: json["commercant_id"],
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
        "nom": nom,
        "addresse": addresse,
        "commercant_id": commercantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "compte": compte?.toJson(),
      };
}
