import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Commande } from 'src/app/models/commande';

@Component({
  selector: 'app-details-commercant',
  templateUrl: './details-commercant.component.html',
  styleUrls: ['./details-commercant.component.scss']
})
export class DetailsCommercantComponent implements OnInit {
  isLoad = true;
  commandes!: Commande[];
  id: any;
  constructor(private route:ActivatedRoute,private AuthSrv:AuthService) { }

  ngOnInit(): void {
    this.id=this.route.snapshot.paramMap.get('id');
    console.log("je suis id :"+this.id);
    this.isLoad = true;
    this.AuthSrv.findCommandeByBoutiqueCommercant(this.id).subscribe({
      next: (response) => {
        this.commandes = response;
        console.log("AZIZ sy Ndiaye"+JSON.stringify(this.commandes) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

}
