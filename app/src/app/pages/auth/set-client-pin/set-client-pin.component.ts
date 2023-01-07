import { NzNotificationService } from 'ng-zorro-antd/notification';
import {
  FormGroup,
  FormBuilder,
  Validators,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { AuthService } from './../../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-set-client-pin',
  templateUrl: './set-client-pin.component.html',
  styleUrls: ['./set-client-pin.component.scss'],
})
export class SetClientPinComponent implements OnInit {
  telephone?: string;
  token!: string;
  isLoad: boolean = false;
  validateForm!: FormGroup;
  constructor(
    private authService: AuthService,
    private fb: FormBuilder,
    private notification: NzNotificationService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe( (data: any) => {
      this.telephone = data.get("telephone") as any
    } )
    this.validateForm = this.fb.group(
      {
        telephone: [
          this.telephone,
          [
            Validators.required,
            Validators.minLength(9),
            Validators.maxLength(9),
            Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
          ],
        ],
        code: [
          null,
          [
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(6),
          ],
        ],
        pin: [
          null,
          [
            Validators.required,
            Validators.minLength(4),
            Validators.maxLength(4),
            Validators.pattern('^[0-9]{4}$'),
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
  }

  save() {
    console.log(this.validateForm.value);
    this.isLoad = true;
    this.authService
      .setClientPassword(
        this.validateForm.value.pin,
        this.validateForm.value.telephone,
        this.validateForm.value.code
      )
      .subscribe({
        next: (response: any) => {
          console.log(response);
          this.notification.success(
            'Notification',
            'Votre compte est maintenant activé.'
          );
          this.isLoad = false;
          this.router.navigate(['/auth']);
        },
        error: (errors:any) => {
          console.log(errors);

          this.isLoad = false;
          if (errors.status == 422) {
            let err = errors.error.errors;
            if (err.telephone) {
              this.notification.error('Erreur', err.telephone[0]);
            }
            if (err.token) {
              this.notification.error('Erreur', err.token[0]);
            }
          }
        },
      });
  }

  checkPasswords: Validators = (
    group: AbstractControl
  ): ValidationErrors | null => {
    let pass = group.value.pin;
    let confirmPass = group.value.pin_conf;
    return pass === confirmPass ? null : { notSame: true };
  };
}
