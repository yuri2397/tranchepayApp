import { Router } from '@angular/router';
import { Admin } from './../../models/admin';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {    
  user!: Admin;     
  dataLoad = true;  
  logoutLoad!: boolean;
  constructor(
    private userService: AuthService, private router: Router
  ) { }

  ngOnInit(): void {
    this.user = this.userService.getFromSession<Admin>('user')!
  }

  imgLoad(event: any){
    if (event && event.target) {
      const width = event.target.naturalWidth;
      const height = event.target.naturalHeight;
      const portrait = height > width ? true : false;
      console.log(width, height, 'portrait: ', portrait);
    }
  }

  logout(){
    this.logoutLoad = true;
    this.userService.logout().subscribe(response => {
      console.log(response);
      
      // this.userService.clearSession();
      // this.router.navigate(['/login']);
    });
  }
}
