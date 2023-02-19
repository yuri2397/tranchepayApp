class Deplafonnement {
  Deplafonnement({
    this.id,
    this.cni,
    this.cniRecto,
    this.cniVerso,
    this.clientId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? cni;
  String? cniRecto;
  String? cniVerso;
  String? clientId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Deplafonnement.fromJson(Map<String, dynamic> json) => Deplafonnement(
        id: json["id"],
        cni: json["cni"],
        cniRecto: json["cni_recto"],
        cniVerso: json["cni_verso"],
        clientId: json["client_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cni": cni,
        "cni_recto": cniRecto,
        "cni_verso": cniVerso,
        "client_id": clientId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
