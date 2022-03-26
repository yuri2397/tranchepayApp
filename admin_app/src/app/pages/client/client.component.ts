import { Client } from './../../models/client';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss']
})
export class ClientComponent implements OnInit {
  clients!: Client[];
  isLoad = true;
  titre:any;
  expandSet = new Set<number>();
  constructor(private Authsrv: AuthService) {}

  ngOnInit(): void {
    this.findAll();
  }

  findAll() {
    this.isLoad = true;
    this.Authsrv.findClients().subscribe({
      next: (response) => {
        this.clients = response;
        console.log("list Clients"+JSON.stringify(this.clients) );
        this.isLoad = false;
      },

      error: (errors) => {
        console.error(errors);
      },
    });
  }


  onExpandChange(id: number, checked: boolean): void {
    if (checked) {
      this.expandSet.add(id);
    } else {
      this.expandSet.delete(id);
    }
  }

  serarchclient()
  {
    if(this.titre=="")
    {
      this.ngOnInit();
    }
    else
    {
      this.clients=this.clients.filter((result: Client)=>{
        return result.prenoms.toLocaleLowerCase().match(this.titre.toLocaleLowerCase());
      })
    }

  }
}
