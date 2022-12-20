import { User } from 'src/app/models/user';
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { finalize, first } from 'rxjs';
import { Client } from 'src/app/models/client';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-update-password',
  templateUrl: './update-password.component.html',
  styleUrls: ['./update-password.component.scss'],
})
export class UpdatePasswordComponent implements OnInit {
  form!: FormGroup;
  user!: User;
  load = false;
  constructor(
    private fb: FormBuilder,
    private notification: NzNotificationService,
    private authService: AuthService,
    private router: Router,
    public location: Location,
    private nofication: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      current_password: [null,  [Validators.required, Validators.minLength(4), Validators.maxLength(4)]],
      new_password: [null,  [Validators.required, Validators.minLength(4), Validators.maxLength(4)]],
      new_password_conf: [null,  [Validators.required, Validators.minLength(4), Validators.maxLength(4)]],
    })

    this.user = this.authService.getUser();
  }

  previewPhone() {
    return (
      this.user.username.substring(0, 2) +
      '******' +
      this.user.username.substring(8, 9)
    );
  }

  checkPasswords: Validators = (
    group: AbstractControl
  ): ValidationErrors | null => {
    let pass = group.value.pin;
    let confirmPass = group.value.pin_conf;
    return pass === confirmPass ? null : { notSame: true };
  };

  save() {
    console.log(this.form.value);
    if(this.form.valid){
      this.load = true;
      this.authService
        .setUserPassword(this.form.value.current_password, this.form.value.new_password)
        .pipe(
          first(),
          finalize(() => (this.load = false))
        )
        .subscribe({
          next: (response: any) => {
            console.log(response);
            this.nofication.success('Succès', response.message);
            this.authService.logout()
            this.router.navigate(['/auth/login'])
          },
          error: (errors) => {
            console.log(errors);
            this.nofication.error('Erreur', errors.error.message);
          },
        });
    }

    
  }
}
