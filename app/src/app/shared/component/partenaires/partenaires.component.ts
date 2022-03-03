import { SharedService } from './../../../services/shared.service';
import { Component, OnInit } from '@angular/core';
import { Partenaire } from 'src/app/models/partenaire';

@Component({
  selector: 'app-partenaires',
  templateUrl: './partenaires.component.html',
  styleUrls: ['./partenaires.component.scss'],
})
export class PartenairesComponent implements OnInit {
  isLoad = true;
  partenaires!: Partenaire[];
  constructor(private pService: SharedService) {}

  ngOnInit(): void {
    this.getPartenaires();
  }

  getPartenaires() {
    this.isLoad = true;
    this.pService.partenaire().subscribe({
      next: (response) => {
        this.partenaires = response;
        this.isLoad = false;
      },
      error: (errors) => {
        console.log(errors);
      },
    });
  }
}
