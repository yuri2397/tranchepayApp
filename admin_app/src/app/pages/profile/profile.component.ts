import { Permission } from './../../models/admin';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Admin } from 'src/app/models/admin';
import { AuthService } from 'src/app/services/auth.service';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
id:any;
isLoad = true;
admin!:Admin;
Permissions!:Permission[];
  constructor(private route:ActivatedRoute,public AuthSrv:AuthService) { }

  ngOnInit(): void {
    this.id=this.route.snapshot.paramMap.get('id');
    this.isLoad = true;
    this.AuthSrv.findAdminById(this.id).subscribe({
      next: (response) => {
        this.admin = response;
        console.log('cheikh bi'+this.admin)
        this.Permissions=this.admin.permissions;
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

}
