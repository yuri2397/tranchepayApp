import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import {
  FormGroup,
  FormBuilder,
  Validators,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-securite',
  templateUrl: './securite.component.html',
  styleUrls: ['./securite.component.scss'],
})
export class SecuriteComponent implements OnInit {
  validateForm!: FormGroup;
  isLoad = false;
  currentSteps = 0;
  current!: string;
  constructor(
    private fb: FormBuilder,
    private notification: NzNotificationService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      current_pin: [
        null,
        [Validators.required, Validators.minLength(4), Validators.maxLength(4)],
      ],
    });
  }

  save() {
    console.log(this.validateForm.value);
    this.isLoad = true;
    if (this.currentSteps == 0) {
      this.authService
        .checkPassword(
          this.validateForm.value.current_pin,
        )
        .subscribe({
          next: (response) => {
            this.isLoad = false;
            this.current = this.validateForm.value.current_pin;
            this.validateForm = this.fb.group(
              {
                pin: [
                  null,
                  [
                    Validators.required,
                    Validators.minLength(4),
                    Validators.maxLength(4),
                  ],
                ],
                pin_conf: [
                  null,
                  [
                    Validators.required,
                    Validators.minLength(4),
                    Validators.maxLength(4),
                  ],
                ],
              },
              { validators: this.checkPasswords }
            );
            this.currentSteps = 1;
          },
          error: (errors) => {
            console.log(errors);
            this.notification.error('Notification', errors.error.message);
            this.isLoad = false;
          },
        });
    } else {
      this.authService
        .setUserPassword(this.current, this.validateForm.value.pin)
        .subscribe({
          next: (response) => {
            console.log(response);
            this.notification.success('Notification', response.message);
            this.authService.logout();
            this.router.navigate(['/auth']);
          },
          error: (errors) => {
            console.error(errors);
          },
        });
    }
  }

  checkPasswords: Validators = (
    group: AbstractControl
  ): ValidationErrors | null => {
    let pass = group.value.pin;
    let confirmPass = group.value.pin_conf;
    return pass === confirmPass ? null : { notSame: true };
  };
}
