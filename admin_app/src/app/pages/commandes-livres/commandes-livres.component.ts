import { Component, OnInit } from '@angular/core';
import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-commandes-livres',
  templateUrl: './commandes-livres.component.html',
  styleUrls: ['./commandes-livres.component.scss']
})
export class CommandesLivresComponent implements OnInit {
  commandes!: Commande[];
  isLoad = true;
  constructor(private Authsrv: AuthService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findFinalCommandes().subscribe({
      next: (response) => {
        this.commandes = response;
        console.log(this.commandes);
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

}
