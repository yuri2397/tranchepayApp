import { User } from 'src/app/models/user';
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { finalize, first } from 'rxjs';
import { Client } from 'src/app/models/client';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-update-phone-number',
  templateUrl: './update-phone-number.component.html',
  styleUrls: ['./update-phone-number.component.scss'],
})
export class UpdatePhoneNumberComponent implements OnInit {
  new_phone_number!: string;
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
    this.user = this.authService.getUser();
  }

  previewPhone() {
    return (
      this.user.username.substring(0, 2) +
      '******' +
      this.user.username.substring(8, 9)
    );
  }

  save() {
    console.log(this.new_phone_number);
    if (this.new_phone_number) {
      this.load = true;
      this.authService
        .updatePhoneNumber(this.new_phone_number)
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
          error: (errors: any) => {
            console.log(errors);
            this.nofication.error('Erreur', errors.error.message);
          },
        });
    }
  }
}
