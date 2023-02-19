// To parse this JSON data, do
//
//     final commande = commandeFromJson(jsonString);

import 'dart:convert';

import 'package:tranchepay_mobile/app/models/%20versement.model.dart';
import 'package:tranchepay_mobile/app/models/boutique.model.dart';
import 'package:tranchepay_mobile/app/models/client.model.dart';
import 'package:tranchepay_mobile/app/models/etat_commande.model.dart';
import 'package:tranchepay_mobile/app/models/produit.model.dart';

List<Commande> commandeFromJson(String str) =>
    List<Commande>.from(json.decode(str).map((x) => Commande.fromJson(x)));

String commandeToJson(List<Commande> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commande {
  Commande({
    this.id,
    this.reference,
    this.prixTotal,
    this.nbProduits,
    this.interet,
    this.nbTranche,
    this.dateTime,
    this.dateLimite,
    this.commission,
    this.boutiqueId,
    this.clientId,
    this.etatCommandeId,
    this.createdAt,
    this.updatedAt,
    this.etatCommande,
    this.produits,
    this.versements,
    this.client,
    this.boutique,
  });

  String? id;
  String? reference;
  double? prixTotal;
  int? nbProduits;
  int? interet;
  int? nbTranche;
  DateTime? dateTime;
  DateTime? dateLimite;
  double? commission;
  String? boutiqueId;
  String? clientId;
  String? etatCommandeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  EtatCommande? etatCommande;
  List<Produit>? produits;
  List<Versement>? versements;
  Client? client;
  Boutique? boutique;

  factory Commande.fromJson(Map<String, dynamic> json) => Commande(
        id: json["id"],
        reference: json["reference"],
        prixTotal: double.tryParse(json["prix_total"]),
        nbProduits: json["nb_produits"],
        interet: json["interet"],
        nbTranche: json["nb_tranche"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        dateLimite: json["date_limite"] == null
            ? null
            : DateTime.parse(json["date_limite"]),
        commission: json["commission"]?.toDouble(),
        boutiqueId: json["boutique_id"],
        clientId: json["client_id"],
        etatCommandeId: json["etat_commande_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        etatCommande: json["etat_commande"] == null
            ? null
            : EtatCommande.fromJson(json["etat_commande"]),
        produits: json["produits"] == null
            ? []
            : List<Produit>.from(
                json["produits"]!.map((x) => Produit.fromJson(x))),
        versements: json["versements"] == null
            ? []
            : List<Versement>.from(
                json["versements"]!.map((x) => Versement.fromJson(x))),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        boutique: json["boutique"] == null
            ? null
            : Boutique.fromJson(json["boutique"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "prix_total": prixTotal,
        "nb_produits": nbProduits,
        "interet": interet,
        "nb_tranche": nbTranche,
        "date_time": dateTime?.toIso8601String(),
        "date_limite":
            "${dateLimite!.year.toString().padLeft(4, '0')}-${dateLimite!.month.toString().padLeft(2, '0')}-${dateLimite!.day.toString().padLeft(2, '0')}",
        "commission": commission,
        "boutique_id": boutiqueId,
        "client_id": clientId,
        "etat_commande_id": etatCommandeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "etat_commande": etatCommande?.toJson(),
        "produits": produits == null
            ? []
            : List<dynamic>.from(produits!.map((x) => x.toJson())),
        "versements": versements == null
            ? []
            : List<dynamic>.from(versements!.map((x) => x)),
        "client": client?.toJson(),
        "boutique": boutique?.toJson(),
      };
}
