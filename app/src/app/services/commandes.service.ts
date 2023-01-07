import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { Commande } from '../models/commande';

@Injectable({
  providedIn: 'root'
})
export class CommandesService extends Base{
  protected override _baseUrl: string = "commandes";
  constructor(protected h: HttpClient) { 
    super()
    this.httpClient = h;
  }


  montantVerser(data: Commande) {
    let res = 0;
    data.versements.forEach((e) => {
      res += e.montant;
    });
    return res;
  }

  montantRestant(data: Commande){
    return Number(data.prix_total) + Number(data.commission) - this.montantVerser(data);
  }
}
