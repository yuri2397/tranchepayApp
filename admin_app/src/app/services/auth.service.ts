import { Commercant } from './../models/commercant';
import { Admin } from './../models/admin';
import { Base } from './../shared/http/base';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LoginResponse } from './../models/login-response';
import { Router } from '@angular/router';
import { Commande } from '../models/commande';
import { Client } from '../models/client';

@Injectable({
  providedIn: 'root'
})
export class AuthService extends Base{
  protected override _baseUrl: string = 'admin/';
  constructor(private h: HttpClient, private router: Router) {
    super();
    this.httpClient = h;
  }

  /**
 * Gére la connexion de l'admin
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  login(email: string, password: string) {
    return this.http.post<LoginResponse>(
      this.endPoint + 'login',
      {
        email: email,
        password: password,
      },
      {
        headers: this.guestHeaders,
        observe: 'body',
      }
    );
  }
 /**
 * trouve la liste des ddernière commandes
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  findCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'last-commandes', {
      headers: this.authorizationHeaders,
    });
  }

   /**
 * la liste des commandes en-cours
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  findProgressCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'load-commmandes', {
      headers: this.authorizationHeaders,
    });
  }
 /**
 * la liste des commandes terminées
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  findFinalCommandes() {
    return this.http.get<Commande[]>(this.endPoint + 'final-commandes', {
      headers: this.authorizationHeaders,
    });
  }

   /**
 * la liste de tous les Clients
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  findClients()
  {
    return this.http.get<Client[]>(this.endPoint + 'clients', {
      headers: this.authorizationHeaders,
    });
  }


   /**
 * La liste des administrateurs
 * @author Abdou Aziz Sy NDIAYE
 * @since 09.03.2022
 */
  findAdmins()
  {
    return this.http.get<Admin[]>(this.endPoint + 'admins', {
      headers: this.authorizationHeaders,
    });
  }


   /**
 * La liste des commercants
 * @author Abdou Aziz Sy NDIAYE
 * @since 11.03.2022
 */
    findCommercants()
    {
      return this.http.get<Commercant[]>(this.endPoint + 'commercants', {
        headers: this.authorizationHeaders,
      });
    }


}
