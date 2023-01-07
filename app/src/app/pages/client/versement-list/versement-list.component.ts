import { ClientService } from './../../../services/client.service';
import { Versement } from './../../../models/versement';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-versement-list',
  templateUrl: './versement-list.component.html',
  styleUrls: ['./versement-list.component.scss'],
})
export class VersementListComponent implements OnInit {
  versements!: Versement[];
  isLoad = true;
  constructor(private clientService: ClientService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.clientService.findVersements(
      {
        'with[]': ['commande', 'commande.boutique'],
      }
    ).subscribe({
      next: (response: any) => {
        this.versements = response;
        this.isLoad = false;
        console.log(response);
        
      },
      error: (errors: any) => {
        console.log(errors);
        this.versements = [];
      },
    });
  }
}
