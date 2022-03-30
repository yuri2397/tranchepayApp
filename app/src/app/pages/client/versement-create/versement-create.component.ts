import { NzModalRef } from 'ng-zorro-antd/modal';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-versement-create',
  templateUrl: './versement-create.component.html',
  styleUrls: ['./versement-create.component.scss']
})
export class VersementCreateComponent implements OnInit {
  load: boolean = false;

  constructor(private modal: NzModalRef) { }

  ngOnInit(): void {
  }

  destroy(data: boolean){
    this.modal.destroy(data);
  }

  save(){
    this.load = true;
  }

}
