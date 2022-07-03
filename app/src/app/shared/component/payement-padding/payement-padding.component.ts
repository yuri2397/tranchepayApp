import { NzModalRef } from 'ng-zorro-antd/modal';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-payement-padding',
  templateUrl: './payement-padding.component.html',
  styleUrls: ['./payement-padding.component.scss']
})
export class PayementPaddingComponent implements OnInit {

  @Input("text") text!: string 
  @Input("load") load: boolean = true; 
  @Input("url") url!: string 
  constructor(private ref: NzModalRef) { }

  ngOnInit(): void {
  }

  close(){
    this.ref.destroy();
  }

}
