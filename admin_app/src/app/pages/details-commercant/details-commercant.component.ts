import { Commercant } from './../../models/commercant';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Commande } from 'src/app/models/commande';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Location } from '@angular/common';

@Component({
  selector: 'app-details-commercant',
  templateUrl: './details-commercant.component.html',
  styleUrls: ['./details-commercant.component.scss'],
})
export class DetailsCommercantComponent implements OnInit {
  isLoad = true;
  commercant!: Commercant;
  commandes!: Commande[];
  id: any;
  titre: any;
  displayCommandes!: Commande[];
  constructor(
    private route: ActivatedRoute,
    private AuthSrv: AuthService,
    private modal: NzModalService,
    private location: Location,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    this.isLoad = true;
    this.AuthSrv.findCommercant(this.id).subscribe({
      next: (response) => {
        this.commercant = response;
        this.displayCommandes=this.commercant.boutique.commandes;
        this.commandes = this.commercant.boutique.commandes;
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  desactiveCompte() {
    this.AuthSrv.dsactiveCompte(this.id, this.commercant).subscribe({
      next: (response) => {
        this.ngOnInit();
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  activeCompte() {
    this.AuthSrv.activeCompte(this.id).subscribe({
      next: (response) => {
        console.log(response);
        this.ngOnInit();
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  showDesactiveConfirm(): void {
    this.modal.confirm({
      nzTitle: 'Voulez vous vraiment Desactiver cet Compte?',
      nzOkText: 'Oui',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => this.desactiveCompte(),
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel'),
    });
  }
  showActiveConfirm(): void {
    this.modal.confirm({
      nzTitle: 'Voulez vous vraiment Activer cet Compte?',
      nzOkText: 'Oui',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => this.activeCompte(),
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel'),
    });
  }

  search(data: string) {
    if (data?.length >= 2)
      this.displayCommandes = this.commandes.filter((result: Commande) => {
        return (
          result.reference
            .toLocaleLowerCase()
            .indexOf(data.toLocaleLowerCase()) != -1 ||
          result.boutique.nom
            .toLocaleLowerCase()
            .indexOf(data.toLocaleLowerCase()) != -1 ||
          result.client.nom
            .toLocaleLowerCase()
            .indexOf(data.toLocaleLowerCase()) != -1 ||
          result.client.prenoms
            .toLocaleLowerCase()
            .indexOf(data.toLocaleLowerCase()) != -1
        );
      });
    else this.displayCommandes = this.commandes;
  }

  onBack() {
    this.location.back();
  }
  showCommande(data: Commande){
    this.router.navigate(["/admin/commandes/show/" + data.id])
  }

  total(data: Commande) {
    return Number(data?.prix_total) + Number(data?.commission);
  }
}
