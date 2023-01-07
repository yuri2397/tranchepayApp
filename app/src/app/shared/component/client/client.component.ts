import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss']
})
export class ClientComponent implements OnInit {
  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list text-dark-green',
    btnConnexion: 'text-dark-green',
    btnInscription:
      'btn btn-sm btn-new-account mx-3 px-2 py-1 text-dark-green',
  };
  menuState!: MenuClass;
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x',
    btnConnexion: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
    btnInscription: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
  };
  isCollapse!: boolean;
  user_type: string = '';

  constructor(public authService: AuthService){}
  
  ngOnInit(): void {
    this.user_type =  this.authService.getUser().model_type.toLocaleLowerCase();
    this.isCollapse = true;
    this.menuState = this.collapse;
  }

  menuClicked() {
    if (!this.isCollapse) {
      this.menuState = this.collapse;
    } else {
      this.menuState = this.expended;
    }
    this.isCollapse = !this.isCollapse;
  }

}
