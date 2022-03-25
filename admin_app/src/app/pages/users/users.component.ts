import { Admin } from './../../models/admin';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { FormBuilder, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { Observable, Observer } from 'rxjs';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
admins!:Admin[];
isLoad=true;
validateForm!: FormGroup;


submitForm(): void {
  console.log('submit', this.validateForm.value);
}

resetForm(e: MouseEvent): void {
  e.preventDefault();
  this.validateForm.reset();
  for (const key in this.validateForm.controls) {
    if (this.validateForm.controls.hasOwnProperty(key)) {
      this.validateForm.controls[key].markAsPristine();
      this.validateForm.controls[key].updateValueAndValidity();
    }
  }
}

  // eslint-disable-next-line @typescript-eslint/explicit-function-return-type
  userNameAsyncValidator = (control: FormControl) =>
    new Observable((observer: Observer<ValidationErrors | null>) => {
      setTimeout(() => {
        if (control.value === 'JasonWood') {
          // you have to return `{error: true}` to mark it as an error event
          observer.next({ error: true, duplicated: true });
        } else {
          observer.next(null);
        }
        observer.complete();
      }, 1000);
    });

  confirmValidator = (control: FormControl): { [s: string]: boolean } => {
    if (!control.value) {
      return { error: true, required: true };
    } else if (control.value !== this.validateForm.controls) {
      return { confirm: true, error: true };
    }
    return {};
  };







constructor(private Authsrv: AuthService,private fb: FormBuilder) {
  this.validateForm = this.fb.group({
    userName: ['', [Validators.required], [this.userNameAsyncValidator]],
    email: ['', [Validators.email, Validators.required]],
    password: ['', [Validators.required]],
    confirm: ['', [this.confirmValidator]],
    comment: ['', [Validators.required]]
  });
}

  ngOnInit(): void {
    this.findAll();
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

}
