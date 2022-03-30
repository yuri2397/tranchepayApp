import { VersementCreateComponent } from './../../versement-create/versement-create.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Commande } from 'src/app/models/commande';
import { CommandesService } from './../../../../services/commandes.service';
import { ClientService } from './../../../../services/client.service';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';

@Component({
  selector: 'app-show',
  templateUrl: './show.component.html',
  styleUrls: ['./show.component.scss'],
})
export class ShowComponent implements OnInit {
  commande!: Commande;
  isLoad = true;
  constructor(
    private route: ActivatedRoute,
    private clientService: ClientService,
    public commandeService: CommandesService,
    private location: Location,
    private modal: NzModalService
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((param) => {
      this.findCommande(param['id']);
    });
  }
  findCommande(id: string) {
    this.isLoad = true;
    this.commandeService.show(id).subscribe({
      next: (response) => {
        console.log(response);
        this.commande = response;
        this.isLoad = false;
      },
      error: (errors) => {
        console.log(errors);
      },
    });
  }

  openAddVersementModal() {
    this.modal
      .create({
        nzTitle: 'Faire un versement',
        nzContent: VersementCreateComponent,
        nzCentered: true,
        nzClosable: false,
        nzMaskClosable: true,
      })
      .afterClose.subscribe((data) => {});
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
    }
    return etat;
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
    }
    return etat;
  }

  onBack() {
    this.location.back();
  }
}
