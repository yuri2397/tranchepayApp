import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { LoginResponse } from 'src/app/models/login-response';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  validateForm!: FormGroup;
  isLoad = false;
  constructor( public router: Router,private AuthSrv:AuthService, private notification: NzNotificationService,   private fb: FormBuilder) { }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      email: [
        null,
        [Validators.required],
      ],
      password: [
        null,
        [Validators.required],
      ],
    });
  }

  submitForm(): void {
    for (const i in this.validateForm.controls) {
      if (this.validateForm.controls.hasOwnProperty(i)) {
        this.validateForm.controls[i].markAsDirty();
        this.validateForm.controls[i].updateValueAndValidity();
      }
    }
  }

  login() {

    console.log("aziz  "+this.validateForm.value.email);
    console.log("sy  "+this.validateForm.value.password);

    this.isLoad = true;
    this.AuthSrv
      .login(this.validateForm.value.email, this.validateForm.value.password)
      .subscribe({
        next: (response) => {
          console.log(response);
          this.loginSuccess(response);
          this.isLoad = false;
        },
        error: (errors) => {
          this.isLoad = false;
          console.log(errors);

          this.notification.create("error", "Message d'erreur", errors.error.message, {
            nzDuration: 5000
          });
        },
      });

        this.router.navigate(['']);

  }


  private loginSuccess(response: LoginResponse) {
    console.log("RESPONSE:", response);

    this.AuthSrv.setToken(response.token.accessToken);
    this.AuthSrv.setUser(response.user);
    this.router.navigate(['admin/dashboard/' + response.user.email ])
  }

}
