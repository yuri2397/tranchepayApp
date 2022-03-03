import { Commande } from './commande';
export class Versement {
    id!: number;
    date_time!: Date;
    via!: string;
    reference!: string;
    montant!: number;
    commande_id!: number;
    commande!: Commande;
    created_at!: Date;
    updated_at!: Date;
}
