import { Commande } from "./commande";

export class Client {
    id!: number;
    prenoms!: string;
    nom!: string;
    telephone!: string;
    adresse!: string;
    deplafonnement!: Deplafonnement;
    pin!: string;
    deplafonner!: number;
    image_path!: null;
    created_at!: Date;
    updated_at!: Date;
    commandes!: Commande[];
}


export interface Deplafonnement{
    client_id: number;
    cni: string;
    cni_recto: string;
    cni_verso: string;
    id: number;
    created_at: Date;
    updated_at: Date
}