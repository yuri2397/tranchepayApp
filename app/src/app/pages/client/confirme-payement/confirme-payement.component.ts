import { ClientService } from './../../../services/client.service';
import { Component, OnInit } from '@angular/core';
import { Payements } from 'src/app/models/payements';
import { ThisReceiver } from '@angular/compiler';

@Component({
  selector: 'app-confirme-payement',
  templateUrl: './confirme-payement.component.html',
  styleUrls: ['./confirme-payement.component.scss']
})
export class ConfirmePayementComponent implements OnInit {
  haveData: boolean = false;
  map = new Map([["om-payement", 'Orange Money'], ["wave", 'wave'], ["free-money", 'Free money']]);
  data: Payements[] = [];
  // data: any;
  statut!: string;
  dataLoad!: boolean;
  constructor(private clientService: ClientService) { }

  ngOnInit(): void {
    this.dataLoad = true;
    this.clientService.paddings().subscribe({
      next: response => {
        this.data = response;
        this.haveData = true;
        this.data.forEach((element: { id: any; created_at: any; reference: any; status: any; type: any; }) => {

          switch (element.type) {
            case "om-payement":
              element.type = "Orange Money";
              break;
            case "wavepayement":
              element.type = "wave";
              break;
            case "freemoneypayement":
              element.type = "Free money";
              break;
            default:
              break;
          };
          switch (element.status) {
            case 0:
              element.status = "EN ATTENTE";
              break;
            case 1:
              element.status = "TERMINÉ";
              break;
            default:
              break;
          }
        });
        this.dataLoad = false;
        console.log(this.data);
      },
      error: errors => {
        console.log(errors);

      }
    })
    console.log(this.map.entries())
  }

  confirme(i: any) {
    this.clientService.confirmePayement(i).subscribe({
      next: response => {
        console.log(response)
      },
      error: errors => {
        console.log(errors);

      }
    })
  }

}
