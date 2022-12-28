import { NzModalService } from 'ng-zorro-antd/modal'
import { Commande } from 'src/app/models/commande'
import { Router } from '@angular/router'
import { NzNotificationService } from 'ng-zorro-antd/notification'
import { ClientService } from './../../services/client.service'
import { Component, OnInit } from '@angular/core'
import { Client } from 'src/app/models/client'
import { FormGroup, FormBuilder, Validators } from '@angular/forms'
import { AuthService } from 'src/app/services/auth.service'
declare interface MenuClass {
  navbar: string
  icon: string
  btnConnexion: string
  btnInscription: string
}

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss'],
})
export class ClientComponent implements OnInit {
  isLoad = true
  selectedCommande!: Commande
  client!: Client
  isVisible = false
  validateForm!: FormGroup
  message = 'Premier versement:'
  solde = 0;
  isFirst = false
  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list text-dark-green',
    btnConnexion: 'text-dark-green',
    btnInscription:
      'btn btn-sm btn-new-account-home mx-3 px-2 py-1 text-whitebtn btn-sm btn-new-account mx-3 px-2 py-1 text-dark-green active',
  }
  menuState!: MenuClass
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x',
    btnConnexion:
      'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
    btnInscription: 'btn active-btn mx-3 py-1',
  }
  isCollapse!: boolean

  isCollapsed = false
  title = 'TRANCHEPAY'
  constructor(
    private router: Router,
    private clientService: ClientService,
    private authService: AuthService,
    private modal: NzModalService,
  ) {}

  logout() {
    this.modal.confirm({
      nzTitle: 'Se déconnecter',
      nzContent:
        '<p class="lead bold">Voulez-vous vraiment vous deconnecter?</p>',
      nzOkText: 'Deconnecter',
      nzCancelText: 'Annuler',
      nzCentered: true,
      nzStyle: {},
      nzOnOk: () => {
        this.authService.logout()
        this.router.navigate(['/auth'])
      },
    })
  }

  ngOnInit(): void {
    this.isCollapse = false
    this.menuState = this.collapse
    this.getClient()

    this.clientService.solde().subscribe(data => this.solde = data);

  }

  getClient() {
    this.isLoad = true
    this.clientService.findClient().subscribe({
      next: (response) => {
        console.log('client: \n', response)
        this.client = response
        this.clientService.setClient(this.client)
        this.isLoad = false
      },
      error: (errors) => {
        console.error(errors)
      },
    })
  }

  menuClicked() {
    if (!this.isCollapse) {
      this.menuState = this.collapse
    } else {
      this.menuState = this.expended
    }
    this.isCollapse = !this.isCollapse
  }

  goto(url: string) {
    this.router.navigate(['/client/' + url])
  }
}
