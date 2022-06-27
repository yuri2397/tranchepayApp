import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { Commercant } from './../../../models/commercant';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
  profile!: Commercant;
  constructor(private authService: AuthService, private router: Router) { }

  ngOnInit(): void {
    this.profile = this.authService.getClient() as Commercant;
    console.log(this.profile);
    
  }

  logout(){
    this.authService.logout();
    this.router.navigate(['/auth']);

  }
}
