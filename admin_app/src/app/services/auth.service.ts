import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LoginResponse } from './../models/login-response';
import { Router } from '@angular/router';
import { Commande } from '../models/commande';

@Injectable({
  providedIn: 'root'
})
export class AuthService extends Base{
  protected override _baseUrl: string = 'admin/';
  constructor(private h: HttpClient, private router: Router) {
    super();
    this.httpClient = h;
  }

  login(username: string, password: string) {
    return this.http.post<LoginResponse>(
      this.endPoint + 'login',
      {
        username: username,
        password: password,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }

  findCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'last-commandes', {
      headers: this.authorizationHeaders,
    });
  }

  findProgressCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'load-commandes', {
      headers: this.authorizationHeaders,
    });
  }

  findFinalCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'final-commandes', {
      headers: this.authorizationHeaders,
    });
  }

}
