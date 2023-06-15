// To parse this JSON data, do
//
//     final modePayement = modePayementFromJson(jsonString);

import 'dart:convert';

List<ModePayement> modePayementFromJson(String str) => List<ModePayement>.from(
    json.decode(str).map((x) => ModePayement.fromJson(x)));

String modePayementToJson(List<ModePayement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModePayement {
  ModePayement({
    this.id,
    this.interet,
    this.label,
    this.nbMois,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? interet;
  String? label;
  int? nbMois;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModePayement copyWith({
    String? id,
    int? interet,
    String? label,
    int? nbMois,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ModePayement(
        id: id ?? this.id,
        interet: interet ?? this.interet,
        label: label ?? this.label,
        nbMois: nbMois ?? this.nbMois,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ModePayement.fromJson(Map<String, dynamic> json) => ModePayement(
        id: json["id"],
        interet: json["interet"],
        label: json["label"],
        nbMois: json["nb_mois"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "interet": interet,
        "label": label,
        "nb_mois": nbMois,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
