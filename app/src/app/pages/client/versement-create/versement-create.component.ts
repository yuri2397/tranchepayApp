import { ClientService } from './../../../services/client.service';
import { CommandesService } from './../../../services/commandes.service';
import { Commande } from 'src/app/models/commande';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { NzModalRef } from 'ng-zorro-antd/modal';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-versement-create',
  templateUrl: './versement-create.component.html',
  styleUrls: ['./versement-create.component.scss'],
})
export class VersementCreateComponent implements OnInit {
  load: boolean = false;
  form!: FormGroup;
  @Input() readonly commande!: Commande;

  constructor(
    private modal: NzModalRef,
    private fb: FormBuilder,
    public commandeService: CommandesService,
    public clientService: ClientService
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      amount: [
        null,
        [
          Validators.required,
          Validators.max(this.commandeService.montantRestant(this.commande)),
        ],
      ],
    });
  }

  destroy(data: string|null) {
    this.modal.destroy(data);
  }

  save() {
    this.load = true;
    this.clientService.doVersement(this.commande, this.form.value.amount).subscribe({
      next: success => {
        this.destroy(success)
      },
      error: errors => {
        console.log(errors);
        
      }
    })
  }
}
