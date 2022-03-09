import { Boutique } from './boutique';
import { EtatVente } from './etat-vente';
import { Client } from './client';

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
    etat_commande!: EtatVente;
}
