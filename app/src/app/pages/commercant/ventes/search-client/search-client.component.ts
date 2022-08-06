import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Client } from 'src/app/models/client';
import { ClientService } from 'src/app/services/client.service';

@Component({
  selector: 'app-search-client',
  templateUrl: './search-client.component.html',
  styleUrls: ['./search-client.component.scss']
})
export class SearchClientComponent implements OnInit {
  searchValue = "";
  clients!: Client[];
  load: boolean=false;
  constructor(
    private location: Location,
    private clientService: ClientService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  back(){
    this.location.back();
  }

  search(data: string){
    if(data){
      this.load = true;
      this.clientService.search(data).subscribe({
        next: response => {
          console.log(response);
          this.clients = response;
          this.load = false;
        }
      })
    }
  }

  goto(i: Client){
    this.router.navigate(["/commercant/finaliser-vente"], {queryParams: {
      customer:JSON.stringify(i)
    }})
  }
}
