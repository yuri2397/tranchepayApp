import { Commercant } from './../../models/commercant';
import { Client } from 'src/app/models/client';
import { Token } from './../../models/token';
export abstract class AbstractPreferences {
  private _token_id: string =
    '3f43ffc3692114ded2a222e57e1b2fb7d1a4b3e106f0a370a441cd93';
  public addInSession(key: string, value: any) {
    sessionStorage.setItem(key, JSON.stringify(value));
  }

  public getFromSession<T>(key: string): T | null {
    let data = sessionStorage.getItem(key);
    if (data) return JSON.parse(data) as T;
    return null;
  }

  public addOnLocalStorage(key: string, value: any) {
    localStorage.setItem(key, JSON.stringify(value));
  }

  public getFromLocalStorage<T>(key: string): T | null {
    let data = localStorage.getItem(key);
    if (data) return JSON.parse(data) as T;
    return null;
  }

  public setToken(token: string) {
    this.addInSession(this._token_id, token);
  }

  public getToken(): string | null {
    return this.getFromSession<string>(this._token_id);
  }

  public setClient(client: Client|Commercant) {
    this.addInSession('_user_data', client);
  }

  public getClient(): Client|Commercant | null {
    return this.getFromSession('_user_data');
  }
}
