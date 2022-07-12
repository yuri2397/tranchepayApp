import {
  FormGroup,
  FormBuilder,
  Validators,
  FormControl,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Admin } from 'src/app/models/admin';
import { AuthService } from 'src/app/services/auth.service';
import { NzMessageService } from 'ng-zorro-antd/message';
import { NzModalService } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  user!: Admin;
  dataLoad = true;
  logoutLoad!: boolean;
  validateForm!: FormGroup;
  isLoad = false;
  constructor(
    private userService: AuthService,
    private router: Router,
    private fb: FormBuilder
  ) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group(
      {
        password: [null, [Validators.required]],
        new_password: [null, [Validators.required]],
        new_password_conf: [null, Validators.required],
      },
      { validators: this.checkPasswords }
    );
    this.user = this.userService.getFromSession<Admin>('user')!;
  }

  imgLoad(event: any) {
    if (event && event.target) {
      const width = event.target.naturalWidth;
      const height = event.target.naturalHeight;
      const portrait = height > width ? true : false;
    }
  }

  checkPasswords: Validators = (
    group: AbstractControl
  ): ValidationErrors | null => {
    let pass = group.value.new_password;
    let confirmPass = group.value.new_password_conf;
    return pass === confirmPass ? null : { notSame: true };
  };

  updatepassword() {}

  logout() {
    this.logoutLoad = true;
    this.userService.logout().subscribe((response) => {
      // this.userService.clearSession();
      // this.router.navigate(['/login']);
    });
  }
}
