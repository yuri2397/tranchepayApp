import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Client } from 'src/app/models/client';
import { Commande } from 'src/app/models/commande';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-details-clients',
  templateUrl: './details-clients.component.html',
  styleUrls: ['./details-clients.component.scss'],
})
export class DetailsClientsComponent implements OnInit {
  isLoad = true;
  client!: Client;
  commandes!: Commande[];
  id: any;
  constructor(
    private route: ActivatedRoute,
    private AuthSrv: AuthService,
    private location: Location,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    this.isLoad = true;
    this.AuthSrv.findClient(this.id).subscribe({
      next: (response) => {
        this.client = response;
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });

    this.AuthSrv.findCommandeByClient(this.id).subscribe({
      next: (response) => {
        this.commandes = response;
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

  goto(data: any) {
    this.router.navigate(['/admin/commandes/show/' + data.id])
  }
}
