import { Client } from './../models/client';
import { ModePaiement } from './../models/mode-paiement';
import { Partenaire } from './../models/partenaire';
import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class SharedService extends Base {
  protected override _baseUrl: string = 'shared/';
  constructor(protected h: HttpClient) {
    super();
    this.httpClient = h;
  }

  partenaire() {
    return this.http.get<Partenaire[]>(this.endPoint + 'partenaires', {
      headers: this.authorizationHeaders,
    });
  }

  modePaiement(client: string) {
    return this.http.get<ModePaiement[]>(this.endPoint + 'mode-paiement/' + client, {
      headers: this.authorizationHeaders,
    });
  }

  checkPadding(padding: any) {
    return this.http.get<any>(this.endPoint + "check-padding/" + padding);
  }
}
