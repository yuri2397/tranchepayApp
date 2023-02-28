import 'dart:convert';

Padding paddingFromJson(String str) => Padding.fromJson(json.decode(str));

String paddingToJson(Padding data) => json.encode(data.toJson());

class Padding {
  Padding({
    this.id,
    this.reference,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.commandeId,
    this.via,
    this.amount,
    this.extra,
  });

  String? id;
  String? reference;
  int? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? commandeId;
  String? via;
  String? amount;
  dynamic extra;

  factory Padding.fromJson(Map<String, dynamic> json) => Padding(
        id: json["id"],
        reference: json["reference"],
        status: json["status"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        commandeId: json["commande_id"],
        via: json["via"],
        amount: json["amount"],
        extra: json["extra"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "status": status,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "commande_id": commandeId,
        "via": via,
        "amount": amount,
        "extra": extra,
      };
}
