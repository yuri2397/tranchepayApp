import { Router } from '@angular/router';
import { AuthService } from './../../../services/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-unauthorization',
  templateUrl: './unauthorization.component.html',
  styleUrls: ['./unauthorization.component.scss']
})
export class UnauthorizationComponent implements OnInit {
  
  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  home(){
    this.router.navigate(['/home'])
  }

}
