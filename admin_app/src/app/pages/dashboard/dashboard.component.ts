import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnDestroy, OnInit } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

   email:any ;
  constructor(private AuthSrv:AuthService,private route:ActivatedRoute) { }

  ngOnInit(): void {
    this.email=this.route.snapshot.paramMap.get('email');
    console.log(this.email)
  }




}
