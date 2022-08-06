import { Boutique } from './../models/boutique';
import { Commande } from 'src/app/models/commande';
import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { DashboardResponse } from '../models/dash-board-response';
import { VentesResponse } from '../models/ventes-response';
import { Client } from '../models/client';
import { Produit } from '../models/produit';
import { Commercant } from '../models/commercant';
import { User } from '../models/user';

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
    mode_paiement: string,
    first_part: number,
    telephone: number,
    type: string,
    via: string
  ) {
    return this.http.post<any>(
      this.endPoint + 'new-commande',
      {
        produits: produits,
        client_id: client_id,
        mode_paiement: mode_paiement,
        first_part: first_part,
        type: type,
        telephone: telephone,
        via: via,
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

  addCommercantUsers(user: Commercant, permissions: string[]) {
    return this.http.post<any>(
      this.endPoint + 'new-user',
      {
        prenom: user.prenoms,
        nom: user.nom,
        adresse: user.adresse,
        telephone: user.telephone,
        permissions: permissions,
      },
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }

  edit(i: Commercant, permissions: string[]) {
    return this.http.put<any>(
      this.endPoint + 'update-user/' + i.id,
      {
        prenom: i.prenoms,
        nom: i.nom,
        adresse: i.adresse,
        telephone: i.telephone,
        permissions: permissions,
      },
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }

  del(i: Commercant) {
    return this.http.delete<any>(this.endPoint + 'remove-user/' + i.id, {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  getUsers() {
    return this.http.get<Commercant[]>(this.endPoint + 'users', {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  doRetrait(amuont: any, via: string, telephone: string) {
    return this.http.post<any>(
      this.endPoint + 'retrait',
      {
        via: via,
        amount: amuont,
        telephone: telephone,
      },
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }
}
