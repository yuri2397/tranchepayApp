import { AuthService } from 'src/app/services/auth.service';
import { Component, OnDestroy, OnInit } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit,OnDestroy {

  constructor(private AuthSrv:AuthService) { }

  ngOnInit(): void {
  }

  ngOnDestroy(): void {
      this.AuthSrv.logout();
  }


}
