import { Permission } from './../../../models/role';
import { AuthService } from 'src/app/services/auth.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Commercant } from './../../../models/commercant';
import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { CommercantService } from 'src/app/services/commercant.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';

@Component({
  selector: 'app-utilisateurs',
  templateUrl: './utilisateurs.component.html',
  styleUrls: ['./utilisateurs.component.scss'],
})
export class UtilisateursComponent implements OnInit {
  users!: Commercant[];
  form!: FormGroup;
  isLoad = true;
  isVisible: boolean = false;
  createLoad: boolean = false;
  permissions!: Permission[];
  hasError = false;
  errors: any;
  selectedPermissions!: string[];
  constructor(
    private comService: CommercantService,
    private fb: FormBuilder,
    private authService: AuthService,

    private notification: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.getUsers();
    this.authService.getPermissions().subscribe({
      next: (response) => {
        this.permissions = response;
      },
    });

    this.form = this.fb.group({
      prenom: [null, [Validators.required]],
      nom: [null, [Validators.required]],
      telephone: [null, [Validators.required]],
      permissions: [null, [Validators.required]],
    });
  }

  edit(i: Commercant) {}

  del(i: Commercant) {}

  addUser() {
    this.isVisible = true;
  }

  save() {
    this.hasError = false;
    this.createLoad = true;
    let commercant = new Commercant();
    commercant.prenoms = this.form.value.prenom;
    commercant.nom = this.form.value.prenom;
    commercant.adresse = this.form.value.adresse;
    commercant.telephone = this.form.value.telephone;
    console.log(commercant, this.selectedPermissions);
    this.comService
      .addCommercantUsers(commercant, this.selectedPermissions)
      .subscribe({
        next: (response) => {
          console.log(response);
          this.isVisible = false;
          this.form.reset();
          this.createLoad = false;
          this.hasError = false;
          this.notification.create(
            'success',
            'Message',
            "L'utilisateur est ajouté avec succès."
          );
          this.getUsers();
        },
        error: (errors) => {
          console.log(errors);
          this.createLoad = false;
          if (errors.status < 500) {
            (this.errors = errors.error.errors), (this.hasError = true);
          } else {
            this.notification.error('Erreur', errors.error.message);
          }
        },
      });
  }
  getUsers() {
    this.isLoad = true;
    this.comService.getUsers().subscribe({
      next: (response) => {
        console.log(response);
        this.users = response;
        this.isLoad = false;
      },
    });
  }
}
