import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

@Component({
  selector: 'app-details-commande',
  templateUrl: './details-commande.component.html',
  styles: [],
})
export class DetailsCommandeComponent implements OnInit {
  id: any;
  isLoad = true;
  commande!: Commande;
  constructor(
    private route: ActivatedRoute,
    public AuthSrv: AuthService,
    private location: Location
  ) {}

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    this.isLoad = true;
    this.AuthSrv.findCommande(this.id).subscribe({
      next: (response) => {
        this.commande = response;
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  onBack() {
    this.location.back();
  }

  total(data: Commande) {
    return Number(data?.prix_total) + Number(data?.commission);
  }
}
