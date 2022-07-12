import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { Commande } from 'src/app/models/commande';
import { da_DK } from 'ng-zorro-antd/i18n';

@Component({
  selector: 'app-commandes',
  templateUrl: './commandes.component.html',
  styleUrls: ['./commandes.component.scss']
})
export class CommandesComponent implements OnInit {
  commandes!: Commande[];
  isLoad = true;
  titre:any;
  displayCommandes!: Commande[];
  constructor(public Authsrv: AuthService, private router: Router) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findCommandes().subscribe({
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

  search(data: string)
  {
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

  show(data: any){
    this.router.navigate(["/admin/commandes/show/" + data.id])
  }

  total(data: Commande){
    return Number(data.prix_total) + Number(data.commission);
  }
}
