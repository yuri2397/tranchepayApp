import { Commande } from 'src/app/models/commande';
import { CommandesService } from './../../../../services/commandes.service';
import { ClientService } from './../../../../services/client.service';
import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-show',
  templateUrl: './show.component.html',
  styleUrls: ['./show.component.scss'],
})
export class ShowComponent implements OnInit {
  commande!: Commande;
  isLoad = true;
  constructor(
    private route: ActivatedRoute,
    private clientService: ClientService,
    public commandeService: CommandesService
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe((param) => {
      this.findCommande(param['id']);
    });
  }
  findCommande(id: string) {
    this.isLoad = true;
    this.commandeService.show(id).subscribe({
      next: (response) => {
        console.log(response);
        this.commande = response;
        this.isLoad = false;
      },
      error: (errors) => {
        console.log(errors);
      },
    });
  }
}
