import { Commercant } from './../models/commercant';
import { DashboardComponent } from './../pages/dashboard/dashboard.component';
import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss'],
})
export class AdminComponent implements OnInit, OnDestroy {
  id: any;
  isCollapsed = false;

  commercants!: Commercant[];
  constructor(
    public Authsrv: AuthService,
    private route: Router,
    private rout: ActivatedRoute
  ) {}

  ngOnInit(): void {

  }

  ngOnDestroy(): void {
    this.signout();
  }

  signout() {
    this.Authsrv.logout();
    this.route.navigate(['']);
  }



  goto(route: string) {
    this.route.navigate(['/admin/' + route]);
  }
}
