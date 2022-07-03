import { RetraitComponent } from './../retrait/retrait.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Boutique } from './../../../models/boutique';
import { CommercantService } from './../../../services/commercant.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-soldes',
  templateUrl: './soldes.component.html',
  styleUrls: ['./soldes.component.scss']
})
export class SoldesComponent implements OnInit {
  boutique!: Boutique;
  isLoad = true;
  constructor(
    private comService: CommercantService,
    private modalService: NzModalService
  ) { }

  ngOnInit(): void {
    this.getSolde();
  }
  getSolde() {
    this.isLoad = true;
    this.comService.getSolde().subscribe({
      next: response => {
        console.log(response);
        this.boutique = response;
        this.isLoad = false;
      },
      error: errors => {
        console.log(errors);
      }
    })
  }

  openRetraitModal(){
    let modal = this.modalService.create({
      nzTitle: "Faire un retrait",
      nzContent: RetraitComponent,
      nzFooter: null,
      nzWidth: "40%",
      nzCentered: true,
      nzComponentParams: {
        boutique: this.boutique
      },
      nzClosable: false,
    });
  }

}
