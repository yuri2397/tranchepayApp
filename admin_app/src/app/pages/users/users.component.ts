import { Admin } from './../../models/admin';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
admins!:Admin[];
isLoad=true;

constructor(private Authsrv: AuthService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findAdmins().subscribe({
      next: (response) => {
        this.admins = response;
        console.log("list admin"+JSON.stringify(this.admins) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

}
