import { Commercant } from './../models/commercant';
import { Router } from '@angular/router';
import { LoginResponse } from './../models/login-response';
import { HttpClient } from '@angular/common/http';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { Client } from '../models/client';

@Injectable({
  providedIn: 'root',
})
export class AuthService extends Base {
  protected override _baseUrl: string = 'auth/';
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

  checkAuthentication() {
    if (this.isLogIn()) {
      const user = this.getUser();
      if (user == null) {
        this.logout();
        this.router.navigate(['/auth/login']);
      } else {
        this.router.navigate(['/' + user.model_type.toLowerCase()]);
      }
    }
  }

  createClient(client: Client) {
    return this.http.post<Client>(
      this.endPoint + 'register-client',
      {
        prenoms: client.prenoms,
        nom: client.nom,
        adresse: client.adresse,
        telephone: client.telephone,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }

  createCommercant(commercant: Commercant) {
    return this.http.post<Commercant>(
      this.endPoint + 'register-commercant',
      {
        prenoms: commercant.prenoms,
        nom: commercant.nom,
        email: commercant.email,
        telephone: commercant.telephone,
        adresse: commercant.adresse,
        boutique: commercant.boutique.nom,
        password: commercant.pin,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }

  setClientPassword(pin: string, telephone: string, code: string) {
    return this.http.post<any>(
      this.endPoint + 'set-client-pin',
      {
        telephone: telephone,
        token: code,
        pin: pin,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }

  setUserPassword(current: string, password: string) {
    return this.http.put<any>(
      this.endPoint + 'new-pin',
      {
        current_pin: current,
        pin: password,
      },
      {
        headers: this.authorizationHeaders,
      }
    );
  }

  checkPassword(password: string) {
    return this.http.post<any>(
      this.endPoint + 'check-password',
      {
        password: password,
      },
      {
        headers: this.authorizationHeaders,
      }
    );
  }

  
}
