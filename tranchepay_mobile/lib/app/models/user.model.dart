// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.username,
    this.email,
    required this.emailVerifyAt,
    this.avatar,
    required this.etat,
    required this.model,
    required this.modelType,
    required this.createdAt,
    required this.updatedAt,
    required this.permissions,
  });

  String id;
  String username;
  dynamic email;
  DateTime emailVerifyAt;
  dynamic avatar;
  int etat = 0;
  String model;
  String modelType;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> permissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    emailVerifyAt: DateTime.parse(json["email_verify_at"]),
    avatar: json["avatar"],
    etat: json["etat"],
    model: json["model"],
    modelType: json["model_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "email_verify_at": emailVerifyAt.toIso8601String(),
    "avatar": avatar,
    "etat": etat,
    "model": model,
    "model_type": modelType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
  };
}
