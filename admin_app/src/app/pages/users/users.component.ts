import { Admin, Permission } from './../../models/admin';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { FormBuilder, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { Observable, Observer } from 'rxjs';
import { NzModalRef, NzModalService } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
admins!:Admin[];
isLoad=true;
validateForm!: FormGroup;
isVisible = false;
isConfirmLoading = false;

passwordVisible = false;
  password?: string;
  listOfOption!:Permission[];
  listOfSelectedValue!:string[];


constructor(private Authsrv: AuthService,private fb: FormBuilder,private modalService: NzModalService) {

}

  ngOnInit(): void {
    this.findAll();
    this.findPermissions();
  }

  findPermissions()
  {
    this.isLoad = true;
    this.Authsrv.allPermissions().subscribe({
      next: (response) => {
        this.listOfOption = response;
        console.log("les Permissions"+JSON.stringify(this.listOfOption) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
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


  showModal(): void {
    this.isVisible = true;
  }

  handleOk(): void {
    this.isVisible = false;
  }

  handleCancel(): void {
    this.isVisible = false;
  }

  showConfirm(): void {
    this.modalService.confirm({
      nzTitle: 'Confirm',
      nzContent: 'Bla bla ...',
      nzOkText: 'OK',
      nzCancelText: 'Cancel'
    });
  }

}
