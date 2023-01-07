import { NzNotificationService } from 'ng-zorro-antd/notification';
import { ClientService } from './../../../services/client.service';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
import { Component, OnInit } from '@angular/core';
declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}
@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.scss'],
})
export class ContactComponent implements OnInit {
  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list text-dark-green',
    btnConnexion: 'text-dark-green',
    btnInscription: 'btn btn-sm btn-new-account mx-3 px-2 py-1 text-dark-green',
  };
  menuState!: MenuClass;
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x',
    btnConnexion:
      'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
    btnInscription:
      'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
  };
  isCollapse!: boolean;
  validateForm!: FormGroup;
  isLoad = false;
  isCommercant = false;
  constructor(
    private fb: FormBuilder,
    private clientService: ClientService,
    private notification: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.isCollapse = true;
    this.menuState = this.collapse;
    this.validateForm = this.fb.group({
      type: [true, [Validators.required]],
      full_name: [null, [Validators.required]],
      email: [null, [Validators.required]],
      telephone: [
        null,
        [
          Validators.minLength(9),
          Validators.maxLength(9),
          Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
        ],
      ],
      message: [null, [Validators.required, Validators.minLength(10)]],
    });
  }

  typeChange(data: any) {
    if (this.validateForm.value.type == 'client') {
      this.validateForm.removeControl('entreprise');
      this.validateForm.removeControl('site');
      this.isCommercant = false;
    } else {
      this.validateForm.addControl(
        'entreprise',
        new FormControl('', [Validators.required])
      );
      this.validateForm.addControl(
        'site',
        new FormControl('', [Validators.minLength(3)])
      );
      this.isCommercant = true;
    }
  }

  menuClicked() {
    if (!this.isCollapse) {
      this.menuState = this.collapse;
    } else {
      this.menuState = this.expended;
    }
    this.isCollapse = !this.isCollapse;
  }

  save() {

    this.isLoad = true;
    this.clientService
      .contactUs(
        this.validateForm.value.type,
        this.validateForm.value.full_name,
        this.validateForm.value.email,
        this.validateForm.value.message,
        this.validateForm.value.telephone,
        this.validateForm.value.site,
        this.validateForm.value.entreprise
      )
      .subscribe({
        next: (response: any) => {
          this.notification.success(
            'Notification',
            'Votre message est envoyé. Merci'
          );
          this.isLoad = false;
          this.validateForm.reset();
        },
        error: (errors: any) => {
          this.isLoad = false;
          this.notification.error('Notification', errors.error.message);
        },
      });
  }
}
