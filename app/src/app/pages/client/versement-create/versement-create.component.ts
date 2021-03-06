import { NzNotificationService } from 'ng-zorro-antd/notification';
import { ClientService } from './../../../services/client.service';
import { Commande } from 'src/app/models/commande';
import { CommandesService } from './../../../services/commandes.service';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NzModalRef } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-versement-create',
  templateUrl: './versement-create.component.html',
  styleUrls: ['./versement-create.component.scss'],
})
export class VersementCreateComponent implements OnInit {
  load: boolean = false;
  form!: FormGroup;
  @Input() readonly commande!: Commande;
  mobilePayements = [
    {
      name: 'wave',
      choice_label: 'Payer avec Wave',
      image_src: '/assets/img/nav-logo.png',
      padding: 'p-3',
      margin_top: '0px',
    },
    {
      name: 'om',
      choice_label: 'Payer avec Orange Money',
      image_src: '/assets/img/orangemoney.png',
      padding: '5px',
      margin_top: '0px',
    },
    {
      name: 'free',
      choice_label: 'Payer avec Free Money',
      image_src: '/assets/img/freemoney.png',
      padding: '5px',
      margin_top: '-6px',
    },
  ];
  constructor(
    private modal: NzModalRef,
    private fb: FormBuilder,
    public commandeService: CommandesService,
    public clientService: ClientService,
    private notification: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      amount: [
        null,
        [
          Validators.required,
          Validators.min(100),
          Validators.max(this.commandeService.montantRestant(this.commande)),
        ],
      ],
      telephone: [
        this.commande.client.telephone,
        [Validators.required, Validators.pattern('^(77|78|75|70|76)[0-9]{7}$')],
      ],
    });
  }

  destroy(data: string | null) {
    this.modal.destroy(data);
  }

  save(via: any) {
    if (this.form.valid) {
      this.load = true;
      this.clientService
        .doVersement(
          this.commande,
          this.form.value.amount,
          via,
          this.form.value.telephone
        )
        .subscribe({
          next: (success) => {
            console.log(success);

            this.destroy(success);
          },
          error: (errors) => {
            console.log(errors);
            this.notification.error('Notification', errors.error.message, {
              nzDuration: 5000,
            });
            this.destroy(null);
          },
        });
    }
  }
}
