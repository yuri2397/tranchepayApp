import { AuthService } from 'src/app/services/auth.service';
import { Client } from 'src/app/models/client';
import { Versement } from 'src/app/models/versement';
import { Commande } from 'src/app/models/commande';
import { first, finalize } from 'rxjs';
import { Component, OnInit } from '@angular/core';
import { ClientService } from 'src/app/services/client.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent implements OnInit {
  load = true;
  lastCommande!: Commande;
  versements!: Versement[];
  solde = 0;
  client!: Client;
  constructor(private clientService: ClientService,
    private router: Router,
    private authService: AuthService
    ) {}

    etatColor(data: Commande) {
      let etat = 'green'
      switch (data.etat_commande.nom) {
        case 'append':
          etat = 'red'
          break
        case 'load':
          etat = 'gold'
          break
        case 'cancel':
          etat = 'red'
          break
      }
      return etat
    }

  ngOnInit(): void {
    this.client = this.authService.getClient() as Client;
    this.clientService
      .findCommandes({
        per_page: 1,
        page: 1,
      })
      .pipe(
        first(),
        finalize(() => (this.load = false))
      )
      .subscribe({
        next: (response: any) => {
          console.log(response);
          if(response && response.data.length != 0)
          this.lastCommande = response.data[0];
        },
        error: (error) => {
          console.log(error);
        },
      });

      this.clientService
      .findVersements({
        per_page: 3,
        page: 1,
      })
      .pipe(
        first(),
        finalize(() => (this.load = false))
      )
      .subscribe({
        next: (response: any) => {
          this.versements = response.data;
          console.log(response);
        },
        error: (error) => {
          console.log(error);
        },
      });
        
      this.clientService.solde().subscribe(data => this.solde = data);
  }

  montantVerser(data: Commande) {
    let res = 0
    data.versements.forEach((e) => {
      res += e.montant
    })
    return res
  }

  montantRestant(data: Commande): number {
    return +data.prix_total + +data.commission - this.montantVerser(data)
  }

  show(item: Commande) {
    this.router.navigate(['/client/commandes/show/' + item.id])
  }

  total(commande: Commande) {
    return +commande.prix_total + +commande.commission
  }

  etatCommande(data: Commande): string {
    let etat = ''
    switch (data.etat_commande.nom) {
      case 'append':
        etat = 'EN ATTENTE'
        break
      case 'load':
        etat = 'EN COURS'
        break
      case 'cancel':
        etat = 'ANNULER'
        break
      case 'finish':
        etat = 'TERMINER'
    }
    return etat
  }
}
