import { Boutique } from './boutique';
import { EtatVente } from './etat-vente';
import { Client } from './client';
import { Produit } from "./produit";
import { Versement } from "./versement";

export class Commande {
    id!: number;
    reference!: string;
    prix_total!: number;
    nb_produits!: number;
    interet!: number;
    nb_tranche!: number;
    date_time!: Date;
    date_limite!: Date;
    boutique_id!: number;
    boutique!: Boutique;
    commission!: number;
    p_tranche!: number;
    client_id!: number;
    created_at!: Date;
    updated_at!: Date;
    client!: Client;
    produits!: Produit[];
    versements!: Versement[];
    etat_commande!: EtatVente;
}


export interface Param{
    [param: string]: string | number | boolean | ReadonlyArray<string | number | boolean>
}