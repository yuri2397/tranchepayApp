import { Commercant } from './../../../models/commercant';
import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { CommercantService } from 'src/app/services/commercant.service';

@Component({
  selector: 'app-utilisateurs',
  templateUrl: './utilisateurs.component.html',
  styleUrls: ['./utilisateurs.component.scss']
})
export class UtilisateursComponent implements OnInit {
  users!: Commercant[]
  isLoad = true;
  constructor(private comService: CommercantService) { }

  ngOnInit(): void {
    this.isLoad = true;
    this.comService.getUsers().subscribe({
      next: response => {
        console.log(response);
      }
    })
  }


  edit(i: Commercant){

  }

  del(i: Commercant){

  }
}
