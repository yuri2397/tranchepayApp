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
  constructor(private Authsrv: AuthService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findProgressCommandes().subscribe({
      next: (response) => {
        this.commandes = response;
        console.log("Lamine"+JSON.stringify(this.commandes));
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }
  serarchcommande()
  {
    if(this.titre=="")
    {
      this.ngOnInit();
    }
    else
    {
      this.commandes=this.commandes.filter((result: Commande)=>{
        return result.reference.toLocaleLowerCase().match(this.titre.toLocaleLowerCase());
      })
    }

  }


}
