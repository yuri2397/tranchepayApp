// To parse this JSON data, do
//
//     final boutique = boutiqueFromJson(jsonString);

import 'dart:convert';

Boutique boutiqueFromJson(String str) => Boutique.fromJson(json.decode(str));

String boutiqueToJson(Boutique data) => json.encode(data.toJson());

class Boutique {
  Boutique({
    this.nom,
    this.addresse,
    this.telephone,
    this.commercantId,
    this.id,
    this.updatedAt,
    this.createdAt,
    this.logo,
  });

  String? nom;
  String? addresse;
  String? telephone;
  String? commercantId;
  String? id;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? logo;

  factory Boutique.fromJson(Map<String, dynamic> json) => Boutique(
        nom: json["nom"],
        addresse: json["addresse"],
        telephone: json["telephone"],
        commercantId: json["commercant_id"],
        id: json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "addresse": addresse,
        "telephone": telephone,
        "commercant_id": commercantId,
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "logo": logo,
      };
}
