import { NzModalRef } from 'ng-zorro-antd/modal';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Component, Input, OnInit } from '@angular/core';
import { Param, ModePayement } from 'src/app/models/param';
import { ParamsService } from 'src/app/services/params.service';

@Component({
  selector: 'app-parametres-edit',
  templateUrl: './parametres-edit.component.html',
  styleUrls: ['./parametres-edit.component.scss'],
})
export class ParametresEditComponent implements OnInit {
  @Input() param!: Param;
  @Input() mode!: ModePayement;
  form!: FormGroup;
  load: boolean = false;
  constructor(
    private fb: FormBuilder,
    private ref: NzModalRef,
    private paramService: ParamsService
  ) {}

  ngOnInit(): void {
    if (this.param) {
      this.form = this.fb.group({
        valeur: [this.param.valeur, [Validators.required]],
      });
    } else {
      this.form = this.fb.group({
        nb_mois: [this.mode.nb_mois, [Validators.required]],
        interet: [this.mode.interet, [Validators.required]],
        label: [this.mode.label, [Validators.required]],
      });
    }
  }

  save() {
    this.load = true;
    if (this.param) {
      this.param.valeur = this.form.value.valeur;
      this.paramService.update(this.param).subscribe({
        next: (response) => {
          this.close(response);
          this.load = false;
        },
        error: (error) => {
          this.load = false;
          this.close(null);
        },
      });
    } else {
      this.mode.interet = this.form.value.interet;
      this.mode.nb_mois = this.form.value.nb_mois;
      this.mode.label = this.form.value.label;

      this.paramService.updateMode(this.mode).subscribe({
        next: (response) => {
          this.close(response);
          this.load = false;
        },
        error: (error) => {
          this.load = false;
          this.close(null);
        },
      });
    }
  }

  close(data: any) {
    this.ref.destroy(data);
  }
}
