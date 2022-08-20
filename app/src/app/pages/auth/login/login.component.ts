import { Router } from '@angular/router';
import { AuthService } from './../../../services/auth.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { LoginResponse } from 'src/app/models/login-response';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { NotificationService } from 'src/app/shared/notification.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent implements OnInit {
  validateForm!: FormGroup;
  isLoad = false;
  errorMessage: any;
  hasError: boolean = false;

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private notification: NzNotificationService,
    private router: Router,
    private alert: NotificationService
  ) {}

  ngOnInit(): void {
    this.authService.checkAuthentication();
    this.validateForm = this.fb.group({
      username: [
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
    this.isLoad = true;
    this.hasError = false;
    this.authService
      .login(this.validateForm.value.username, this.validateForm.value.password)
      .subscribe({
        next: (response) => {
          this.loginSuccess(response);
          this.isLoad = false;
        },
        error: (errors) => {
          this.isLoad = false;
          console.log(errors);
          this.errorMessage = errors.error.message
          this.hasError = true;
        },
      });
  }

  private loginSuccess(response: LoginResponse) {
    console.log("EMEINT EVENT");
    
    this.alert.logoutEvent()    
    this.authService.setToken(response.token.accessToken);
    this.authService.setUser(response.user);
    this.authService.setClient(response.data);
    this.router.navigate(['/' + response.user.model_type.toLowerCase() ])
  }
}
