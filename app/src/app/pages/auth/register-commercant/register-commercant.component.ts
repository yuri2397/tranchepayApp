import { Commercant } from './../../../models/commercant';
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import {
  FormGroup,
  FormBuilder,
  Validators,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { Router } from '@angular/router';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { Client } from 'src/app/models/client';
import { AuthService } from 'src/app/services/auth.service';
declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}
@Component({
  selector: 'app-register-commercant',
  templateUrl: './register-commercant.component.html',
  styleUrls: ['./register-commercant.component.scss'],
})
export class RegisterCommercantComponent implements OnInit {
  currentYear:any;
  validateForm!: FormGroup;
  isLoad = false;
  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list text-dark-green',
    btnConnexion: 'text-dark-green',
    btnInscription:
      'btn btn-sm btn-new-account-home mx-3 px-2 py-1 text-whitebtn btn-sm btn-new-account mx-3 px-2 py-1 text-dark-green active',
  };
  menuState!: MenuClass;
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x',
    btnConnexion:
      'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
    btnInscription: 'btn active-btn mx-3 py-1',
  };

  isCollapse!: boolean;
  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private notification: NzNotificationService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.currentYear = new Date().getFullYear();
    this.isCollapse = true;
    this.menuState = this.collapse;

    this.validateForm = this.fb.group(
      {
        prenoms: [null, [Validators.required]],
        nom: [null, [Validators.required]],
        boutique: [null, [Validators.required]],
        adresse: [null, [Validators.required]],
        email: [null, [Validators.required, Validators.email]],
        telephone: [
          null,
          [
            Validators.required,
            Validators.minLength(9),
            Validators.maxLength(9),
            Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
          ],
        ],
        pin: [
          null,
          [Validators.required,
            Validators.minLength(4),
            Validators.maxLength(12),],
        ],
        pin_conf: [
          null,
          [
          ],
        ],
      },
      { validators: this.checkPasswords }
    );
  }

  menuClicked() {
    console.log('MENU', this.isCollapse);
    if (!this.isCollapse) {
      this.menuState = this.collapse;
    } else {
      this.menuState = this.expended;
    }
    this.isCollapse = !this.isCollapse;
  }

  submitForm() {}

  save() {
    this.isLoad = true;
    let commercant = new Commercant();
    commercant.prenoms = this.validateForm.value.prenoms;
    commercant.nom = this.validateForm.value.nom;
    commercant.telephone = this.validateForm.value.telephone;
    commercant.pin = this.validateForm.value.pin;
    commercant.boutique.nom = this.validateForm.value.boutique;
    commercant.adresse = this.validateForm.value.adresse;
    commercant.email = this.validateForm.value.email;
    this.authService.createCommercant(commercant).subscribe({
      next: (response) => {
        this.notification.create(
          'success',
          'Notification',
          'Votre compte est bien crée.'
        );
        this.router.navigate(['/auth/login']);
      },
      error: (errors) => {
        if (errors.status == 422) {
          let err = errors.error.errors;
          if (err.telephone) {
            this.notification.error('Erreur', err.telephone[0]);
          }
          if (err.boutique) {
            this.notification.error('Erreur', err.boutique[0]);
          }
        }
        this.isLoad = false;
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
