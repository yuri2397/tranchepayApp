import { Router } from '@angular/router';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { Client } from 'src/app/models/client';
import { AuthService } from './../../../services/auth.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}
@Component({
  selector: 'app-register-client',
  templateUrl: './register-client.component.html',
  styleUrls: ['./register-client.component.scss'],
})
export class RegisterClientComponent implements OnInit {
  validateForm!: FormGroup;
  isLoad = false;
  @ViewChild('preloader') preloader!: ElementRef;
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
    btnConnexion: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
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
    this.isCollapse = true;
    this.menuState = this.collapse;
    setTimeout(() => {
      this.preloader.nativeElement.remove();
    }, 1500);
    this.validateForm = this.fb.group({
      prenoms: [null, [Validators.required]],
      nom: [null, [Validators.required]],
      telephone: [
        null,
        [
          Validators.required,
          Validators.minLength(9),
          Validators.maxLength(9),
          Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
        ],
      ],
    });
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
    let client = new Client();
    client.prenoms = this.validateForm.value.prenoms;
    client.nom = this.validateForm.value.nom;
    client.telephone = this.validateForm.value.telephone;
    this.authService.createClient(client).subscribe({
      next: (response) => {
        this.notification.create(
          'success',
          'Notification',
          'Votre compte est bien crée.'
        );
        this.router.navigate(['client-code-pin']);
        this.isLoad = false;
      },
      error: (errors) => {
        this.isLoad = false;
        if (errors.status == 422) {
          let err = errors.error.errors;
          if (err.telephone[0]) {
            this.notification.error('Erreur', err.telephone[0]);
          }
          if (err.boutique[0]) {
            this.notification.error('Erreur', err.boutique[0]);
          }
        }
      },
    });
  }
}
