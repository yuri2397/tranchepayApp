import { Admin } from './../../models/admin';
import { AbstractPreferences } from './preference';
import { environment as env } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
export class Base extends AbstractPreferences {
  private _host = env.host;
  private _api = env.api;
  protected _baseUrl!: string;
  protected httpClient!: HttpClient;

  constructor() {
    super();
  }

  isLogIn(): boolean {
    return this.getToken() == null ? false : true;
  }

  get authorizationHeaders() {
    return {
      Accept: 'application/json',
      'Content-type': 'application/json',
      Authorization: 'Bearer ' + this.getToken()!,
    };
  }

  get guestHeaders() {
    return {
      Accept: 'application/json',
      'Content-type': 'application/json',
    };
  }
  setUser(user: Admin) {
    sessionStorage.setItem('user', JSON.stringify(user));
  }
  get http() {
    return this.httpClient;
  }

  set http(http) {
    this.httpClient = http;
  }
  get api(): string {
    return this._api;
  }

  get host(): string {
    return this._host;
  }
  get endPoint() {
    return this.api + this.baseUrl;
  }
  get baseUrl(): string {
    return this._baseUrl;
  }

  logout() {
    return this.http.get(this.api + 'admin/logout',{
      headers: this.authorizationHeaders
    });
  }

  clearSession() {
    sessionStorage.clear();
    localStorage.clear();
  }
}
