class Compte {
  Compte({
    this.id,
    this.solde,
    this.boutiqueId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? solde;
  String? boutiqueId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Compte.fromJson(Map<String, dynamic> json) => Compte(
        id: json["id"],
        solde: json["solde"],
        boutiqueId: json["boutique_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "solde": solde,
        "boutique_id": boutiqueId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
