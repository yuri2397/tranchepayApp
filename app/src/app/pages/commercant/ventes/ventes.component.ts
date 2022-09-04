import { Router } from '@angular/router';
import { VentesResponse } from './../../../models/ventes-response';
import { CommercantService } from './../../../services/commercant.service';
import { Component, OnInit } from '@angular/core';
import { Commande } from 'src/app/models/commande';
import { NzModalService } from 'ng-zorro-antd/modal';
import { NzDrawerService } from 'ng-zorro-antd/drawer';
import { CommandesComponent } from '../../client/commandes/commandes.component';
import { AjouterVentesComponent } from './ajouter-ventes/ajouter-ventes.component';
import { Versement } from 'src/app/models/versement';

@Component({
  selector: 'app-ventes',
  templateUrl: './ventes.component.html',
  styleUrls: ['./ventes.component.scss'],
})
export class VentesComponent implements OnInit {
  visible = false;
  montantRestant!: number;
  listOfDisplayData: any[] = [];
  listOfData: any[] = [];
  searchValue = '';
  data!: VentesResponse;
  isLoad = true;
  constructor(
    private commercantService: CommercantService,
    private modalService: NzModalService,
    private drawerService: NzDrawerService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.getData();
  }
  addition(a: any, b: any) {
    return parseInt(a) + parseInt(b);
  }

  getData() {
    this.isLoad = true;
    this.commercantService.getVentes().subscribe({
      next: (response) => {
        this.data = response;
        this.isLoad = false;
      },
      error: (errors) => {
        this.isLoad = false;
        console.log(errors);
      },
    });
  }
  montantR(data: Commande) {
    this.montantRestant = 0
    data.versements.forEach(e => {
      this.montantRestant += e.montant;
    })
    return parseInt(data.prix_total.toString()) + parseInt(data.commission.toString()) - this.montantRestant;
  }

  etatColor(data: Commande) {
    let etat = 'green';
    switch (data.etat_commande.nom) {
      case 'append':
        etat = 'red';
        break;
      case 'load':
        etat = 'gold';
        break;
      case 'cancel':
        etat = 'red';
        break;
    }
    return etat;
  }

  etatCommande(data: Commande): string {
    let etat = '';
    switch (data.etat_commande.nom) {
      case 'append':
        etat = 'EN ATTENTE';
        break;
      case 'load':
        etat = 'EN COURS';
        break;
      case 'finish':
        etat = 'TERMINER';
        break
        case 'cancel':
        etat = 'ANNULER';
    }
    return etat;
  }

  reset(): void {
    this.searchValue = '';
    this.search();
  }

  search(): void {
    this.visible = false;
    this.listOfDisplayData = this.listOfData.filter(
      (item: any) => item.name.indexOf(this.searchValue) !== -1
    );
  }

  etatVente(vente: Commande) {
    let total_versement = 0;
    vente.versements.forEach((element) => {
      total_versement += element.montant;
    });
    if (total_versement < vente.prix_total) return false;
    return true;
  }

  openCreateVenteModal() {
    this.router.navigate(['/commercant/search-client-vente']);
  }

  goto(route: string) {
    this.router.navigate([route]);
  }

  // montantRestant(data: Commande): number {
  //   return (+data.prix_total + +data.commission) - this.montantVerser(data);
  // }
  // montantVerser(data: Commande) {
  //   let res = 0;
  //   data.versements.forEach((e) => {
  //     res += e.montant;
  //   });
  //   return res;
  // }
}
