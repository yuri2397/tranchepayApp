import { FormGroup, FormBuilder } from '@angular/forms';
import { Component, Input, OnInit } from '@angular/core';
import { Param } from 'src/app/models/param';

@Component({
  selector: 'app-parametres-edit',
  templateUrl: './parametres-edit.component.html',
  styleUrls: ['./parametres-edit.component.scss'],
})
export class ParametresEditComponent implements OnInit {
  @Input() param!: Param;
  form!: FormGroup;
  constructor(
    private fb: FormBuilder
  ) {}

  ngOnInit(): void {}
}
