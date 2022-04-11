import { Commercant } from './../models/commercant';
import { Admin, Permission } from './../models/admin';
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

  getCurrentUser(){
    return this.setUser
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

  findCommercant(id:any)
  {
    return this.http.get<Commercant>(this.endPoint + 'commercants/'+id, {
      headers: this.authorizationHeaders,
    });
  }

  allPermissions()
  {
    return this.http.get<Permission[]>(this.endPoint + 'all-permissions', {
      headers: this.authorizationHeaders,
    });
  }

  createAdmn(admin: Admin) {
    console.log("mamaa"+admin);
    return this.http.post<Admin>(

      this.endPoint + 'new-admin',
      {
        full_name: admin.full_name,
        email: admin.email,
        permissions: admin.tab_permission,
      },
      {
        headers:this.authorizationHeaders,
        observe: 'body',
      }
    );
  }


  findCommande(id:any)
  {
    return this.http.get<Commande>(this.endPoint + 'commande/'+id, {
      headers: this.authorizationHeaders,
    });
  }

  findClient(id:any)
  {
    return this.http.get<Client>(this.endPoint + 'clients/'+id, {
      headers: this.authorizationHeaders,
    });
  }

  findCommandeByClient(id:any)
  {
    return this.http.get<Commande[]>(this.endPoint + 'commande-client/'+id, {
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

  findCommercantInacif()
  {
    return this.http.get<Commercant[]>(this.endPoint + 'commercant-inactif', {
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

    montantVerser(data: Commande) {
      let res = 0;
      data.versements.forEach((e) => {
        res += e.montant;
      });
      return res;
    }

    findAdminById(id:any)
    {
      return this.http.get<Admin>(this.endPoint + 'admin/'+id, {
        headers: this.authorizationHeaders,
      });
    }
    fidMisssingPermission(admin:Admin)
    {
      return this.http.post<Admin>(

        this.endPoint + 'missing',
        {
          full_name: admin.full_name,
          email: admin.email,
          permissions:Array(admin.permissions) ,
        },
        {
          headers:this.authorizationHeaders,
          observe: 'body',
        }
      );
    }


    deleteAdmin(id:any)
    {
      return this.http.delete<Admin>(this.endPoint + 'delete/'+id, {
        headers: this.authorizationHeaders,
      });
    }

    EditAdmin(id:any,admin:Admin)
    {



      return this.http.put<Admin>(
        this.endPoint + 'edit-admin/'+id,
        {
          id: id,
          email: admin.email,
          full_name:admin.full_name,
          permissions:admin.permissions
        },
        {
          headers: this.authorizationHeaders,

        }
      );
    }

}
