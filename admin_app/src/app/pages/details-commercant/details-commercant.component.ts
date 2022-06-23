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
  titre:any;
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

  desactiveCompte()
  {
    this.AuthSrv.dsactiveCompte(this.id,this.commercant).subscribe({
      next: (response) => {
      console.log(response);
      this.ngOnInit();
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  activeCompte()
  {
    this.AuthSrv.activeCompte(this.id).subscribe({
      next: (response) => {
      console.log(response);
      this.ngOnInit();
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
      nzOnOk: () => this.desactiveCompte(),
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel')
    });
  }
  showActiveConfirm(): void {
    this.modal.confirm({
      nzTitle: 'Voulez vous vraiment Activer cet Compte?',
      nzOkText: 'Oui',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => this.activeCompte(),
      nzCancelText: 'Non',
      nzOnCancel: () => console.log('Cancel')
    });
  }


  serarchcommande()
  {
    if(this.titre=="")
    {
      this.ngOnInit();
    }
    else
    {
      this.commandes=this.commandes.filter((result: Commande)=>{
        return result.reference.toLocaleLowerCase().match(this.titre.toLocaleLowerCase());
      })
    }
  }

}
