import { Retrait } from './retrait';
export interface Compte {
    id:          number;
    solde:       number;
    boutique_id: number;
    created_at:  Date;
    updated_at:  Date;
    retraits:    Retrait[];
}
