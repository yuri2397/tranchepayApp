import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { Commande } from 'src/app/models/commande';

@Component({
  selector: 'app-commandes',
  templateUrl: './commandes.component.html',
  styleUrls: ['./commandes.component.scss']
})
export class CommandesComponent implements OnInit {
  commandes!: Commande[];
  isLoad = true;
  constructor(private Authsrv: AuthService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findCommandes().subscribe({
      next: (response) => {
        this.commandes = response;
        console.log("AZIZ"+JSON.stringify(this.commandes) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }


}
