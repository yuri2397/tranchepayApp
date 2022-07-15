import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-commandes-livres',
  templateUrl: './commandes-livres.component.html',
  styleUrls: ['./commandes-livres.component.scss'],
})
export class CommandesLivresComponent implements OnInit {
  commandes!: Commande[];
  isLoad = true;
  titre: any;
  displayCommandes!: Commande[];
  constructor(public Authsrv: AuthService, private modal: NzModalService, private router: Router) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findFinalCommandes().subscribe({
      next: (response) => {
        this.commandes = response;
        this.displayCommandes = response;
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
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

  showDeleteConfirm(): void {
    this.modal.confirm({
      nzTitle: 'Voulez vous vraiment supprimer cet Commande?',
      nzOkText: 'Oui',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzCentered: true,
      nzOnOk: () => 'Ok',
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel'),
    });
  }

  total(data: Commande){
    return Number(data.prix_total) + Number(data.commission);
  }

  show(data: any){
    this.router.navigate(["/admin/commandes/show/" + data.id])
  }
}
