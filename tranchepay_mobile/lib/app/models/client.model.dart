import 'package:tranchepay_mobile/app/models/deplafonnement.model.dart';

class Client {
  Client({
    this.id,
    this.prenoms,
    this.nom,
    this.telephone,
    this.adresse,
    this.imagePath,
    this.deplafonner,
    this.createdAt,
    this.updatedAt,
    this.deplafonnement,
  });

  String? id;
  String? prenoms;
  String? nom;
  String? telephone;
  dynamic adresse;
  dynamic imagePath;
  int? deplafonner;
  DateTime? createdAt;
  DateTime? updatedAt;
  Deplafonnement? deplafonnement;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        prenoms: json["prenoms"],
        nom: json["nom"],
        telephone: json["telephone"],
        adresse: json["adresse"],
        imagePath: json["image_path"],
        deplafonner: json["deplafonner"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deplafonnement: json["deplafonnement"] == null
            ? null
            : Deplafonnement.fromJson(json["deplafonnement"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prenoms": prenoms,
        "nom": nom,
        "telephone": telephone,
        "adresse": adresse,
        "image_path": imagePath,
        "deplafonner": deplafonner,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deplafonnement": deplafonnement?.toJson(),
      };
}
