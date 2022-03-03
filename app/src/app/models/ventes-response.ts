import { Commande } from './commande';
    export interface VentesResponse {
        tous:     Commande[];
        en_cours: Commande[];
        terminer: Commande[];
    }
