class Produit {
  Produit({
    this.id,
    this.nom,
    this.quantite,
    this.prixUnitaire,
    this.imagePath,
    this.commandeId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? nom;
  int? quantite;
  int? prixUnitaire;
  dynamic imagePath;
  String? commandeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        id: json["id"],
        nom: json["nom"],
        quantite: json["quantite"],
        prixUnitaire: json["prix_unitaire"],
        imagePath: json["image_path"],
        commandeId: json["commande_id"],
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
        "quantite": quantite,
        "prix_unitaire": prixUnitaire,
        "image_path": imagePath,
        "commande_id": commandeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  Produit copyWith() {
    return Produit(
      id: id,
      nom: nom,
      quantite: quantite,
      prixUnitaire: prixUnitaire,
      imagePath: imagePath,
      commandeId: commandeId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
