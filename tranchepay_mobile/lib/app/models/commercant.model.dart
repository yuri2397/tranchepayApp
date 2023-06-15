import 'dart:convert';

import 'boutique.model.dart';

Commercant commercantFromJson(String str) => Commercant.fromJson(json.decode(str));

String commercantToJson(Commercant data) => json.encode(data.toJson());

class Commercant {
  Commercant({
    this.id,
    this.prenoms,
    this.nom,
    this.telephone,
    this.adresse,
    this.email,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    this.boutique,
  });

  String? id;
  String? prenoms;
  String? nom;
  String? telephone;
  String? email;
  String? adresse;
  dynamic imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;
  Boutique? boutique;

  factory Commercant.fromJson(Map<String, dynamic> json) => Commercant(
    id: json["id"],
    prenoms: json["prenoms"],
    nom: json["nom"],
    email: json["email"],
    telephone: json["telephone"],
    adresse: json["adresse"],
    imagePath: json["image_path"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    boutique: json["boutique"] == null ? null : Boutique.fromJson(json["boutique"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "prenoms": prenoms,
    "nom": nom,
    "telephone": telephone,
    "adresse": adresse,
    "email": email,
    "image_path": imagePath,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "boutique": boutique?.toJson(),
  };
}