import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PartenaireService } from './../../../services/partenaire.service';
import { NzModalModule, NzModalRef } from 'ng-zorro-antd/modal';
import { Component, OnInit } from '@angular/core';
import { Partenaire } from 'src/app/models/partenaire';

@Component({
  selector: 'app-partenaire-create',
  templateUrl: './partenaire-create.component.html',
  styleUrls: ['./partenaire-create.component.scss'],
})
export class PartenaireCreateComponent implements OnInit {
  form!: FormGroup;
  createLoad: boolean = false;
  types: any = [];

  constructor(
    private ref: NzModalRef,
    private fb: FormBuilder,
    private pService: PartenaireService
  ) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      nom: [null, [Validators.required]],
      logo_url: [null, [Validators.required]],
      type: [null, [Validators.required]],
      site_web: [null, []],
    });

    this.getTypes();
  }

  getTypes(){
    this.pService.getTypes().subscribe({
      next: data => {
        this.types = data;
      }
    })
  }

  _submitForm(value: any){
    this.createLoad = true;
    this.pService.create(value).subscribe({
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
