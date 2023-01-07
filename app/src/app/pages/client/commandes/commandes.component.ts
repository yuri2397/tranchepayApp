import { Router } from '@angular/router'
import { ClientService } from './../../../services/client.service'
import { Component, OnInit } from '@angular/core'
import { Commande } from 'src/app/models/commande'

@Component({
  selector: 'app-commandes',
  templateUrl: './commandes.component.html',
  styleUrls: ['./commandes.component.scss'],
})
export class CommandesComponent implements OnInit {
  commandes!: Commande[]
  isLoad = true
  constructor(private clientService: ClientService, private router: Router) {}

  ngOnInit(): void {
    this.findAll()
  }

  findAll() {
    this.isLoad = true
    this.clientService.findCommandes(
      {
        'with[]': ['versements', 'boutique'],
      }
    ).subscribe({
      next: (response: any) => {
        this.commandes = response
        console.log(this.commandes)
        this.isLoad = false
      },

      error: (errors: any) => {
        console.error(errors)
      },
    })
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

  show(item: Commande) {
    this.router.navigate(['/client/commandes/show/' + item.id])
  }

  total(commande: Commande) {
    return +commande.prix_total + +commande.commission
  }
}
