import { NzNotificationService } from 'ng-zorro-antd/notification';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ClientService } from './../../../services/client.service';
import { Client } from 'src/app/models/client';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-deplafonnement',
  templateUrl: './deplafonnement.component.html',
  styleUrls: ['./deplafonnement.component.scss'],
})
export class DeplafonnementComponent implements OnInit {
  client!: Client;
  isLoad = true;
  isBtnLoad = false;
  validateForm!: FormGroup;
  rectoPreview = "/assets/img/recto.png"
  versoPreview = "/assets/img/verso.png"
  cniRecto!: File;
  cniVerso!: File;
  constructor(
    private clientService: ClientService,
    private fb: FormBuilder,
    private notification: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      cni: [
        null,
        [Validators.required, Validators.pattern('^(1|2)[0-9]{12}$')],
      ],
    });
    this.findClient();
  }

  etatCompte() {
    if (this.client.deplafonner == 0) {
      return 'Déplafonner votre compte';
    } else {
      return 'Votre compte est déplafonner';
    }
  }

  findClient() {
    this.isLoad = true;
    this.clientService.findClient().subscribe({
      next: (response: any) => {
        this.client = response;
        this.isLoad = false;
      },
      error: (errors: any) => {
        console.log(errors);
      },
    });
  }

  recto(data: any) {
    this.cniRecto = data.target.files[0];
  }

  verso(data: any) {
    this.cniVerso = data.target.files[0];
  }

  save() {
    
    this.isBtnLoad = true;
    this.clientService
      .deplafonnement(this.validateForm.value.cni, this.cniRecto, this.cniVerso)
      .subscribe({
        next: (response: any) => {
          this.notification.success("Notification", response.message);
          this.isBtnLoad = false;
        },
        error: (errors: any) => {
          console.log(errors);
          this.isBtnLoad = false;
        },
      });
  }
}
