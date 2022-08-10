import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Client } from 'src/app/models/client';
import { ClientService } from 'src/app/services/client.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { NzNotificationService } from 'ng-zorro-antd/notification';

@Component({
  selector: 'app-search-client',
  templateUrl: './search-client.component.html',
  styleUrls: ['./search-client.component.scss']
})
export class SearchClientComponent implements OnInit {
  searchValue = "";
  isLoad = false;
  clients!: Client[];
  validateForm!: FormGroup;
  load: boolean=false;
  modalVisible!: boolean;
  constructor(
    private location: Location,
    private clientService: ClientService,
    private router: Router,
    private fb: FormBuilder,
    private authService: AuthService,
    private notification: NzNotificationService
  ) { }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
      prenoms: [null, [Validators.required]],
      nom: [null, [Validators.required]],
      telephone: [
        null,
        [
          Validators.required,
          Validators.minLength(9),
          Validators.maxLength(9),
          Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
        ],
      ],
    });
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

  createClient(){
    this.modalVisible = true;
  }


  save() {
    this.isLoad = true;
    let client = new Client();
    client.prenoms = this.validateForm.value.prenoms;
    client.nom = this.validateForm.value.nom;
    client.telephone = this.validateForm.value.telephone;
    this.authService.createClient(client).subscribe({
      next: (response) => {
        this.notification.create(
          'success',
          'Notification',
          'Le compte client est bien crée.'
        );
        this.isLoad = false;
        this.searchValue = client.telephone;
        this.modalVisible = false;
      },
      error: (errors) => {
        this.isLoad = false;
        if (errors.status == 422) {
          let err = errors.error.errors;
          if (err.telephone[0]) {
            this.notification.error('Erreur', err.telephone[0]);
          }
          if (err.boutique[0]) {
            this.notification.error('Erreur', err.boutique[0]);
          }
        }
      },
    });
  }
}
