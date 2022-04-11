import { Commercant } from './../../models/commercant';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Commande } from 'src/app/models/commande';
import { NzModalService } from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-details-commercant',
  templateUrl: './details-commercant.component.html',
  styleUrls: ['./details-commercant.component.scss']
})
export class DetailsCommercantComponent implements OnInit {
  isLoad = true;
  commercant!: Commercant;
  commandes!:Commande[];
  id: any;
  constructor(private route:ActivatedRoute,private AuthSrv:AuthService,private modal: NzModalService) { }

  ngOnInit(): void {
    this.id=this.route.snapshot.paramMap.get('id');
    console.log("je suis id :"+this.id);
    this.isLoad = true;
    this.AuthSrv.findCommercant(this.id).subscribe({
      next: (response) => {
        this.commercant = response;
        this.commandes=this.commercant.boutique.commandes;
        console.log("AZIZ sy Ndiaye"+JSON.stringify(this.commercant) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  showDesactiveConfirm(): void {
    this.modal.confirm({
      nzTitle: 'Voulez vous vraiment Desactiver cet Compte?',
      nzOkText: 'Oui',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => 'Ok',
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel')
    });
  }

}
