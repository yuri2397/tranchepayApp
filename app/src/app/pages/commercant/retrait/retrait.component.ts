import { NzModalRef } from 'ng-zorro-antd/modal';
import { ClientService } from './../../../services/client.service';
import { Boutique } from './../../../models/boutique';
import { Component, Input, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-retrait',
  templateUrl: './retrait.component.html',
  styleUrls: ['./retrait.component.scss'],
})
export class RetraitComponent implements OnInit {
  @Input() boutique!: Boutique;
  isLoad = false;
  validateForm!: FormGroup;

  constructor(private clientService: ClientService, private fb: FormBuilder, private ref: NzModalRef) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      montant: [
        null,
        [Validators.required, Validators.min(0), Validators.max(this.boutique.compte.solde)],
        ,
      ],
      telephone: [null, [Validators.required, Validators.minLength(9), Validators.maxLength(9)]]
    });
  }

  submitForm(): void {
    for (const i in this.validateForm.controls) {
      if (this.validateForm.controls.hasOwnProperty(i)) {
        this.validateForm.controls[i].markAsDirty();
        this.validateForm.controls[i].updateValueAndValidity();
      }
    }
  }

  handleOk() {
  }

  handleCancel() {
    this.ref.destroy(null);
  }
}
