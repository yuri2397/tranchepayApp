// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.email,
    this.emailVerifyAt,
    this.avatar,
    this.etat,
    this.model,
    this.modelType,
    this.createdAt,
    this.updatedAt,
    this.permissions,
  });

  String? id;
  String? username;
  dynamic email;
  dynamic emailVerifyAt;
  dynamic avatar;
  int? etat;
  String? model;
  String? modelType;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? permissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        emailVerifyAt: json["email_verify_at"],
        avatar: json["avatar"],
        etat: json["etat"],
        model: json["model"],
        modelType: json["model_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        permissions: json["permissions"] == null
            ? []
            : List<dynamic>.from(json["permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "email_verify_at": emailVerifyAt,
        "avatar": avatar,
        "etat": etat,
        "model": model,
        "model_type": modelType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
      };
}
