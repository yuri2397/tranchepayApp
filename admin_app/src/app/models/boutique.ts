import { Compte } from './compte';
export class Boutique {
    id!: number;
    nom!: string;
    addresse!: string;
    commercant_id!: number;
    compte!: Compte;
    created_at!: Date;
    updated_at!: Date;
}
