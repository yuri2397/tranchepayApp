import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-details-commande',
  templateUrl: './details-commande.component.html',
  styles: [
  ]
})
export class DetailsCommandeComponent implements OnInit {
  id: any;
  isLoad = true;
  commande!:Commande;
  constructor(private route: ActivatedRoute,public AuthSrv:AuthService) { }

  ngOnInit(): void {
    this.id=this.route.snapshot.paramMap.get('id');
    console.log("je suis id :"+this.id);
    this.isLoad = true;
    this.AuthSrv.findCommande(this.id).subscribe({
      next: (response) => {
        this.commande = response;
        console.log("Mady coly"+JSON.stringify(this.commande) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });


  }


}
