import { Router } from '@angular/router';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss']
})
export class AdminComponent implements OnInit,OnDestroy {

  constructor(private Authsrv: AuthService,private route:Router) { }

  ngOnInit(): void {
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
