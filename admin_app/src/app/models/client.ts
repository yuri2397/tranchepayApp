import { Commande } from "./commande";

export class Client {
    id!: number;
    prenoms!: string;
    nom!: string;
    telephone!: string;
    adresse!: string;
    pin!: string;
    deplafonner!: number;
    image_path!: null;
    created_at!: Date;
    updated_at!: Date;
    commandes!: Commande[];
}
