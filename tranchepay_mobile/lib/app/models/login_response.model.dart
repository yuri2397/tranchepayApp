import 'dart:convert';

import 'package:tranchepay_mobile/app/models/user.model.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.token,
    this.user,
    this.permissions,
  });

  LoginResponseToken? token;
  User? user;
  List<dynamic>? permissions;
  String? modelType;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"] == null
            ? null
            : LoginResponseToken.fromJson(json["token"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        permissions: json["permissions"] == null
            ? []
            : List<dynamic>.from(json["permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "token": token?.toJson(),
        "user": user?.toJson(),
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
      };
}

class LoginResponseToken {
  LoginResponseToken({
    this.accessToken,
    this.token,
  });

  String? accessToken;
  TokenToken? token;

  factory LoginResponseToken.fromJson(Map<String, dynamic> json) =>
      LoginResponseToken(
        accessToken: json["accessToken"],
        token:
            json["token"] == null ? null : TokenToken.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "token": token?.toJson(),
      };
}

class TokenToken {
  TokenToken({
    this.id,
    this.userId,
    this.clientId,
    this.name,
    this.scopes,
    this.revoked,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
  });

  String? id;
  String? userId;
  String? clientId;
  dynamic name;
  List<dynamic>? scopes;
  bool? revoked;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? expiresAt;

  factory TokenToken.fromJson(Map<String, dynamic> json) => TokenToken(
        id: json["id"],
        userId: json["user_id"],
        clientId: json["client_id"],
        name: json["name"],
        scopes: json["scopes"] == null
            ? []
            : List<dynamic>.from(json["scopes"]!.map((x) => x)),
        revoked: json["revoked"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "client_id": clientId,
        "name": name,
        "scopes":
            scopes == null ? [] : List<dynamic>.from(scopes!.map((x) => x)),
        "revoked": revoked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "expires_at": expiresAt?.toIso8601String(),
      };
}
