import { CommercantService } from 'src/app/services/commercant.service';
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
  constructor(private comService: CommercantService, private fb: FormBuilder, private ref: NzModalRef) {}

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      montant: [
        null,
        [Validators.required, Validators.min(100), Validators.max(this.boutique.compte.solde)],
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

  handleOk(via: string) {
    if(this.validateForm.valid){
      this.isLoad = true;
    }
    
  }

  handleCancel() {
    this.ref.destroy(null);
  }
}
