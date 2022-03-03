import { Commande } from "./commande";

export interface DashboardResponse {
    annee:  number;
    mois:   number;
    jour:   number;
    ventes: Commande[];
}