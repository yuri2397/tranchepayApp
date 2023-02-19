class EtatCommande {
  EtatCommande({
    this.id,
    this.nom,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? nom;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EtatCommande.fromJson(Map<String, dynamic> json) => EtatCommande(
        id: json["id"],
        nom: json["nom"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
