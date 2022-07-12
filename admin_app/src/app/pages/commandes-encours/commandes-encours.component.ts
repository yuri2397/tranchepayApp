import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-commandes-encours',
  templateUrl: './commandes-encours.component.html',
  styleUrls: ['./commandes-encours.component.scss']
})
export class CommandesEncoursComponent implements OnInit {

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
    this.Authsrv.findProgressCommandes().subscribe({
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

  total(data: Commande){
    return Number(data.prix_total) + Number(data.commission);
  }

  show(data: any){
    this.router.navigate(["/admin/commandes/show/" + data.id])
  }
}
