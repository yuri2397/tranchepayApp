import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Partenaire } from '../models/partenaire';
import { Base } from '../shared/http/base';

@Injectable({
  providedIn: 'root',
})
export class PartenaireService extends Base {
  protected override _baseUrl: string = 'admin/partenaire';
  constructor(private h: HttpClient, private router: Router) {
    super();
    this.httpClient = h;
  }

  all() {
    return this.http.get<Partenaire[]>(this.endPoint, {
      headers: this.authorizationHeaders,
    });
  }

  create(partanaire: Partenaire) {
    return this.http.post<Partenaire>(this.endPoint + '/create', partanaire, {
      headers: this.authorizationHeaders,
    });
  }

  getTypes() {
    return this.http.get<any>(this.endPoint + '/partenaire-types', {
      headers: this.authorizationHeaders,
    });
  }

  update(partanaire: Partenaire) {
    return this.http.post<Partenaire>(
      this.endPoint + '/update/' + partanaire.id,
      partanaire,
      {
        headers: this.authorizationHeaders,
      }
    );
  }

  remove(partanaire: Partenaire) {
    return this.http.post<Partenaire>(
      this.endPoint + '/remove/' + partanaire.id,
      partanaire,
      {
        headers: this.authorizationHeaders,
      }
    );
  }
}
