import { Boutique } from './../models/boutique';
import { Commande } from 'src/app/models/commande';
import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { DashboardResponse } from '../models/dash-board-response';
import { VentesResponse } from '../models/ventes-response';
import { Client } from '../models/client';
import { Produit } from '../models/produit';

@Injectable({
  providedIn: 'root',
})
export class CommercantService extends Base {
  protected override _baseUrl: string = 'commercant/';
  constructor(private h: HttpClient) {
    super();
    this.httpClient = h;
  }

  getStatistique() {
    return this.http.get<DashboardResponse>(this.endPoint + 'dashboard', {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  createCommande(
    produits: Produit[],
    client_id: number,
    mode_paiement: number,
    p_tranche: number,
    type: string
  ) {
    return this.http.post<any>(
      this.endPoint + 'new-commande',
      {
        produits: produits,
        client_id: client_id,
        mode_paiement: mode_paiement,
        first_part: p_tranche,
        type: type
      },
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }

  getVentes() {
    return this.http.get<VentesResponse>(this.endPoint + 'ventes', {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  findByClientTelephone(telephone: string) {
    return this.http.get<Client[]>(
      this.endPoint + 'search-client/' + telephone,
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }

  getSolde() {
    return this.http.get<Boutique>(this.endPoint + 'solde', {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }
}