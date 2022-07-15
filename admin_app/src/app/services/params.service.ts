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

  modePayement(){
    return this.http.get<ModePayement[]>(this.endPoint+"/payements", {
      headers: this.authorizationHeaders,
    });
  }
}
