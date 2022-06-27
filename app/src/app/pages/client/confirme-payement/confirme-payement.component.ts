import { ClientService } from './../../../services/client.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-confirme-payement',
  templateUrl: './confirme-payement.component.html',
  styleUrls: ['./confirme-payement.component.scss']
})
export class ConfirmePayementComponent implements OnInit {
  data: any;
  constructor(private clientService: ClientService) { }

  ngOnInit(): void {
    this.clientService.paddings().subscribe({
      next: response => {
        console.log(response)
      },
      error: errors =>{
        console.log(errors);
        
      }
    })
  }

  confirme(i: any){
    this.clientService.confirmePayement(i).subscribe({
      next: response => {
        console.log(response)
      },
      error: errors =>{
        console.log(errors);
        
      }
    })
  }

}
