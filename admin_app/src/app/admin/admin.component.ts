import { Commercant } from './../models/commercant';
import { DashboardComponent } from './../pages/dashboard/dashboard.component';
import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss']
})
export class AdminComponent implements OnInit,OnDestroy {
id:any;
dashbord!:DashboardComponent;
commercants!:Commercant[];
  constructor(private Authsrv: AuthService,private route:Router,private rout: ActivatedRoute) { }

  ngOnInit(): void {
    console.log("cc c'est moi"+this.dashbord.email);
    this.findCommercantInactif();

  }
  ngOnDestroy(): void
  {
   this.signout();
  }

  signout()
  {
    this.Authsrv.logout();
    this.route.navigate(['']);
  }

  findCommercantInactif()
  {
    this.Authsrv.findCommercantInacif().subscribe({
      next: (response) => {
        this.commercants = response;
        console.log("AZIZ 97"+JSON.stringify(this.commercants) );

      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

}
