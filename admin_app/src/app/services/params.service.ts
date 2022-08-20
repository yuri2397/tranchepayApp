import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { ModePayement, Param } from '../models/param';
import { Base } from '../shared/http/base';

@Injectable({
  providedIn: 'root',
})
export class ParamsService extends Base {
  protected override _baseUrl: string = 'admin/parametres';
  constructor(private h: HttpClient, private router: Router) {
    super();
    this.httpClient = h;
  }

  all() {
    return this.http.get<Param[]>(this.endPoint, {
      headers: this.authorizationHeaders,
    });
  }

  modePayement() {
    return this.http.get<ModePayement[]>(this.endPoint + '/payements', {
      headers: this.authorizationHeaders,
    });
  }

  update(param: Param) {
    return this.http.post<Param>(this.endPoint + '/update/' + param.id, param, {
      headers: this.authorizationHeaders,
    });
  }

  updateMode(mode: ModePayement) {
    return this.http.post<ModePayement>(this.endPoint + '/update-interet/' + mode.id, mode, {
      headers: this.authorizationHeaders,
    });
  }
}
