import { Router } from '@angular/router';
import { Commercant } from './../../models/commercant';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-commercant',
  templateUrl: './commercant.component.html',
  styleUrls: ['./commercant.component.scss']
})
export class CommercantComponent implements OnInit {
  isLoad = true;
  commercants!:Commercant[];
  expandSet = new Set<number>();
  titre:any;
  constructor(private Authsrv:AuthService,private route:Router) { }

  ngOnInit(): void {
    this.findAll();
  }

  onExpandChange(id: number, checked: boolean): void {
    if (checked) {
      this.expandSet.add(id);
    } else {
      this.expandSet.delete(id);
    }
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findCommercants().subscribe({
      next: (response) => {
        this.commercants = response;
        console.log("AZIZ sy Ndiaye"+JSON.stringify(this.commercants) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }

  serarchcommercant()
  {
    if(this.titre=="")
    {
      this.ngOnInit();
    }
    else
    {
      this.commercants=this.commercants.filter((result: Commercant)=>{
        return result.prenoms.toLocaleLowerCase().match(this.titre.toLocaleLowerCase());
      })
    }

  }


}
