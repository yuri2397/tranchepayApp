import { Router } from '@angular/router';
import { AuthService } from './../../../services/auth.service';
import { ClientService } from './../../../services/client.service';
import { Client } from 'src/app/models/client';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup, AbstractControl, ValidationErrors } from '@angular/forms';
import { NzNotificationService } from 'ng-zorro-antd/notification';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  validateFormAddCB!: FormGroup;
  validateForm!: FormGroup;
  isLoad = false;
  currentSteps = 0;
  current!: string;
  client!: Client;
  constructor(
    private clientService: ClientService,
    private authService: AuthService,
    private router: Router,
    private fb: FormBuilder,
    private notification: NzNotificationService,

  ) { }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      current_pin: [
        null,
        [Validators.required, Validators.minLength(4)],
      ],
    });
    this.validateFormAddCB = this.fb.group({
      iban: [null, [Validators.required]],
      bic: [null, [Validators.required]],
      nom: [null, [Validators.required]],
      type: [null, [Validators.required]],
      libelle: [null, [Validators.required]],
    });
    this.client = this.clientService.getClient() as Client;
  }

  save() {
    console.log(this.validateForm.value);
    this.isLoad = true;
    if (this.currentSteps == 0) {
      this.authService
        .checkPassword(this.validateForm.value.current_pin)
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
                  ],
                ],
                pin_conf: [
                  null,
                  [
                    Validators.required,
                    Validators.minLength(4),
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


  logout() {
    this.authService.logout();
    this.router.navigate(['/auth']);
  }
  checkPasswords: Validators = (
    group: AbstractControl
  ): ValidationErrors | null => {
    let pass = group.value.pin;
    let confirmPass = group.value.pin_conf;
    return pass === confirmPass ? null : { notSame: true };
  };
}
