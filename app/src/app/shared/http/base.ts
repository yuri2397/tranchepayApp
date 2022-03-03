import { Commercant } from './../../models/commercant';
import { Token } from './../../models/token';
import { HttpClient } from '@angular/common/http';
import { Role } from 'src/app/models/role';
import { User } from 'src/app/models/user';
import { environment as env } from '../../../environments/environment';
import { AbstractPreferences } from './preferences';

export class Base extends AbstractPreferences {
  private _host = env.host;
  private _api = env.api;
  protected _baseUrl!: string;
  private _super_admin = 'super admin';
  private _editeur = 'chef de département';
  protected httpClient!: HttpClient;
  protected _returnUrl = 'http://tranchepay.com/';
  protected _cancelUrl = 'http://tranchepay.com/';

  _canDeleteErreurs!: string[];
  _canDeleteSubTitle!: string;
  _canDeleteTitle!: string;

  constructor() {
    super();
  }

  isLogIn(): boolean {
    return this.getToken() == null ? false : true;
  }

  checkLocalData(): boolean {
    return this.getRoles() && this.getUser() && this.getToken() ? true : false;
  }

  get authorizationHeaders() {
    return {
      Accept: 'application/json',
      'Content-type': 'application/json',
      Authorization: 'Bearer ' + this.getToken()!,
    };
  }

  get canDeleteErreurs() {
    return this._canDeleteErreurs;
  }

  get canDeleteSubTitle() {
    return this._canDeleteSubTitle;
  }

  get canDeleteTitle() {
    return this._canDeleteTitle;
  }

  set canDeleteErreurs(value: string[]) {
    this._canDeleteErreurs = value;
  }

  set canDeleteSubTitle(value: string) {
    this._canDeleteSubTitle = value;
  }

  set canDeleteTitle(value: string) {
    this._canDeleteTitle = value;
  }

  findSelectableList(tables: string[]) {
    return this.http.post<any>(this.api + 'selectable', tables, {
      headers: this.authorizationHeaders,
      observe: 'body',
    });
  }

  get http() {
    return this.httpClient;
  }

  set http(http) {
    this.httpClient = http;
  }

  isAdmin(): boolean {
    let role: string = this.getRoles()[0].name;
    if (role == this._super_admin) {
      return true;
    }
    return false;
  }

  isEditeur(): boolean {
    let role: string = this.getRoles()[0].name;
    if (role == this._editeur) {
      return true;
    }
    return false;
  }

  get super_admin() {
    return this._super_admin;
  }

  get editeur() {
    return this._editeur;
  }

  get endPoint() {
    return this.api + this.baseUrl;
  }

  get guestHeaders() {
    return {
      Accept: 'application/json',
      'Content-type': 'application/json',
    };
  }

  getRoles(): Role[] {
    return JSON.parse(sessionStorage.getItem('roles')!) as Role[];
  }

  get baseUrl(): string {
    return this._baseUrl;
  }

  set baseUrl(baseUrl: string) {
    this._baseUrl = baseUrl;
  }

  getUser(): User {
    return JSON.parse(sessionStorage.getItem('user')!);
  }


  setUser(user: User) {
    sessionStorage.setItem('user', JSON.stringify(user));
  }

  setModelType(model: string) {
    sessionStorage.setItem('model_type', model);
  }

  getModelType() {
    return sessionStorage.getItem('model_type');
  }

  setRoles(roles: Role[]) {
    sessionStorage.setItem('roles', JSON.stringify(roles));
  }

  get api(): string {
    return this._api;
  }

  get host(): string {
    return this._host;
  }

  hasRole(role: Role): boolean {
    return this.getRoles().some((x) => x.name === role.name);
  }

  clone(item: any) {
    throw new Error('Method clone unimplemented.');
  }

  isCommercant() {
    const commercant = this.getUser();
    if (commercant && commercant.model_type == 'Commercant') {
      return true;
    }
    return false;
  }

  isClient() {
    const commercant = this.getUser();
    if (commercant && commercant.model_type == 'Client') {
      return true;
    }
    return false;
  }

  logout() {
    sessionStorage.clear();
    localStorage.clear();
  }
}
