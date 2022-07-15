import { Partenaire } from 'src/app/models/partenaire';
import { Component, Input, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { NzModalModule, NzModalRef } from 'ng-zorro-antd/modal';
import { PartenaireService } from 'src/app/services/partenaire.service';

@Component({
  selector: 'app-partenaire-edit',
  templateUrl: './partenaire-edit.component.html',
  styleUrls: ['./partenaire-edit.component.scss']
})
export class PartenaireEditComponent implements OnInit {
  @Input() partenaire?: Partenaire
  form!: FormGroup;
  createLoad: boolean = false;

  constructor(
    private ref: NzModalRef,
    private fb: FormBuilder,
    private pService: PartenaireService
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      nom: [this.partenaire?.nom, [Validators.required]],
      logo_url: [this.partenaire?.logo_url, [Validators.required]],
      site_web: [this.partenaire?.site_web, []],
    });
  }

  _submitForm(value: any){
    value.id = this.partenaire?.id;
    this.createLoad = true;
    this.pService.update(value).subscribe({
      next:response => {
        this.createLoad = false;
        this.destroy(response)
      },
      error: error => {
        this.createLoad = false;
        console.log(error);
      }
    })
  }

  destroy(p: Partenaire|null)
  {
    this.ref.destroy(p)
  }

}
