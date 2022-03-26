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
  constructor(private Authsrv: AuthService,private route:Router,private rout: ActivatedRoute) { }

  ngOnInit(): void {
    console.log("cc c'est moi"+this.dashbord.email)

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

}
