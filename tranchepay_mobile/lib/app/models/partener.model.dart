// To parse this JSON data, do
//
//     final partener = partenerFromJson(jsonString);

import 'dart:convert';

List<Partener> partenerFromJson(String str) =>
    List<Partener>.from(json.decode(str).map((x) => Partener.fromJson(x)));

String partenerToJson(List<Partener> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Partener {
  Partener({
    this.id,
    this.nom,
    this.siteWeb,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  String? id;
  String? nom;
  String? siteWeb;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  PartenerType? type;

  factory Partener.fromJson(Map<String, dynamic> json) => Partener(
        id: json["id"],
        nom: json["nom"],
        siteWeb: json["site_web"],
        logoUrl: json["logo_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        type: json["type"] == null ? null : PartenerType.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "site_web": siteWeb,
        "logo_url": logoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type?.toJson(),
      };
}

class PartenerType {
  PartenerType({
    this.id,
    this.nom,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nom;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PartenerType.fromJson(Map<String, dynamic> json) => PartenerType(
        id: json["id"],
        nom: json["nom"],
        code: json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
