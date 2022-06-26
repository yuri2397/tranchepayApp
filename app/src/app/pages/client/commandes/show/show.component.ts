import { NzNotificationService } from 'ng-zorro-antd/notification';
import { VersementCreateComponent } from './../../versement-create/versement-create.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Commande } from 'src/app/models/commande';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { CommandesService } from 'src/app/services/commandes.service';

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
    public commandeService: CommandesService,
    private location: Location,
    private modal: NzModalService,
    private notification: NzNotificationService
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
        nzComponentParams: {
          commande: this.commande,
        },
        nzCentered: true,
        nzClosable: false,
        nzMaskClosable: false,
      })
      .afterClose.subscribe((data: string | null) => {
        if (data) {
          this.notification.success('Notification', 'Votre versement est en préparation, vous serez rediriger d\'ici peu');
          window.location.href = data;
        }
      });
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
