export interface Retrait {
  id:          number;
  montant:     number;
  date:        Date;
  via:         string;
  description: string;
  compte_id:   number;
}
