import { AuthService } from './../../../services/auth.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { Client } from 'src/app/models/client';
import { ClientService } from './../../../services/client.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { NzModalRef } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-create-client',
  templateUrl: './create-client.component.html',
  styleUrls: ['./create-client.component.scss'],
})
export class CreateClientComponent implements OnInit {
  validateForm!: FormGroup;
  isLoad = false;
  constructor(
    private fb: FormBuilder,
    private clientService: ClientService,
    private authService: AuthService,
    private modal: NzModalRef,
    private notification: NzNotificationService
  ) {}

  submitForm(): void {
    for (const i in this.validateForm.controls) {
      if (this.validateForm.controls.hasOwnProperty(i)) {
        this.validateForm.controls[i].markAsDirty();
        this.validateForm.controls[i].updateValueAndValidity();
      }
    }
  }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      prenoms: [null, [Validators.required]],
      nom: [null, [Validators.required]],
      telephone: [
        null,
        [Validators.required, Validators.minLength(9), Validators.maxLength(9)],
      ],
      adresse: [null, [Validators.required]],
    });
  }

  destroyModal(data: Client | null): void {
    this.modal.destroy(data);
  }

  save() {
    this.isLoad = true;
    let client = new Client();
    client.prenoms = this.validateForm.value.prenoms;
    client.nom = this.validateForm.value.nom;
    client.telephone = this.validateForm.value.telephone;
    client.adresse = this.validateForm.value.adresse;
    
    this.authService.createClient(client).subscribe({
      next: (response:any) => {
        this.destroyModal(response);
        this.isLoad = false;
      },
      error: (errors:any) => {
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
        this.destroyModal(null);
      },
    });
  }
}
