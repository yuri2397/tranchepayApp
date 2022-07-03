import { DeplafonnementComponent } from './../pages/client/deplafonnement/deplafonnement.component';
import { Versement } from './../models/versement';

import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { Client } from 'src/app/models/client';
import { Commande } from '../models/commande';

@Injectable({
  providedIn: 'root',
})
export class ClientService extends Base {
  protected override _baseUrl = 'client/';
  constructor(private h: HttpClient) {
    super();
    this.httpClient = h;
  }

  findClient() {
    return this.http.get<Client>(this.endPoint + 'profile', {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  findVersements() {
    return this.http.get<Versement[]>(this.endPoint + 'versements', {
      headers: this.authorizationHeaders,
    });
  }

  createClient(client: Client) {
    return this.http.post<Client>(
      this.endPoint + 'create',
      {
        prenoms: client.prenoms,
        nom: client.nom,
        adresse: client.adresse,
        telephone: client.telephone,
        password: client.pin ?? -1,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }

  doVersement(selectedCommande: Commande, montant: string, via: string) {
    return this.http.post<any>(
      this.endPoint + 'do-versement',
      {
        montant: montant,
        commande_id: selectedCommande.id,
        via: via
      },
      {
        headers: this.authorizationHeaders,
        observe: 'body',
      }
    );
  }

  contactUs(
    type: string,
    full_name: string,
    email: string,
    message: string,
    telephone?: string,
    site?: string,
    entreprise?: string
  ) {
    return this.http.post<any>(
      this.api + 'contact-us',
      {
        full_name: full_name,
        email: email,
        message: message,
        telephone: telephone,
        type: type,
        site: site,
        entreprise: entreprise,
      },
      {
        headers: this.guestHeaders,
      }
    );
  }

  findCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'commandes', {
      headers: this.authorizationHeaders,
    });
  }

  paddings() {
    return this.http.get<any[]>(this.endPoint + 'paddings', {
      headers: this.authorizationHeaders,
    });
  }

  confirmePayement(i: any){
    return this.http.post<any>(this.endPoint + 'paddings/confirme/' + i.id, {
      headers: this.authorizationHeaders,
    });
  }

  deplafonnement(cni: string, recto: any, verso: any) {
    var myFormData = new FormData();
    myFormData.append('cni', cni);
    myFormData.append('recto', recto);
    myFormData.append('verso', verso);

    return this.http.post<any>(this.endPoint + 'deplafonnement', myFormData, {
      headers: {
        Accept: 'application/json',
        Authorization: 'Bearer ' + this.getToken(),
      },
    });
  }


}
