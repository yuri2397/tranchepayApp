import { Router } from '@angular/router';
import { Admin, Permission } from './../../models/admin';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

import {
  FormBuilder,
  FormControl,
  FormGroup,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { Observable, Observer } from 'rxjs';
import { NzModalRef, NzModalService } from 'ng-zorro-antd/modal';
import { ToastrService } from 'ngx-toastr';


@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss'],
})
export class UsersComponent implements OnInit {
  admins!: Admin[];
  isLoad = true;
  isVisible = false;
  isConfirmLoading = false;
  user: Admin = {
    id: 0,
    email: '',
    full_name: '',
    permissions: [],
    tab_permission: [],
  };

  listOfOption!: Permission[];
  listOfSelectedValue!: string[];

  constructor(
    public Authsrv: AuthService,
    private fb: FormBuilder,
    private modalService: NzModalService,
    private router: Router,
    private toastr: ToastrService

  ) {}

  ngOnInit(): void {
    this.findAll();
    this.findPermissions();
  }

  save() {
    this.user.tab_permission = this.listOfSelectedValue;
    this.Authsrv.createAdmn(this.user).subscribe({
      next: (response) => {
        this.user = response;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  findPermissions() {
    this.isLoad = true;
    this.Authsrv.allPermissions().subscribe({
      next: (response) => {
        this.listOfOption = response;
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
    this.save();
    this.isVisible = false;
    this.toastr.success('Enregistrement effecué avec succès', 'Success');
    this.findAll();
  }

  handleCancel(): void {
    this.isVisible = false;
  }

  showConfirm(): void {
    this.modalService.confirm({
      nzTitle: 'Confirm',
      nzContent: 'Bla bla ...',
      nzOkText: 'OK',
      nzCancelText: 'Cancel',
    });
  }

  show(user: any) {
    this.router.navigate(['/admin/user/show/' + user.id])
  }


}
