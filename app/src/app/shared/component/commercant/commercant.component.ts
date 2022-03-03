import { Component, OnInit } from '@angular/core';
declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}
@Component({
  selector: 'app-commercant',
  templateUrl: './commercant.component.html',
  styleUrls: ['./commercant.component.scss']
})
export class CommercantComponent implements OnInit {

  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list text-dark-green',
    btnConnexion: '',
    btnInscription:
      'btn btn-sm btn-new-account mx-3 px-2 py-1 text-dark-green',
  };
  menuState!: MenuClass;
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x text-white',
    btnConnexion: 'btn btn-sm  mx-3 px-2 py-1',
    btnInscription: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
  };

  isCollapse!: boolean;
  constructor() {}

  ngOnInit(): void {
    this.isCollapse = true;
    this.menuState = this.collapse;
  }

  menuClicked() {
    console.log('MENU', this.isCollapse);
    if (!this.isCollapse) {
      this.menuState = this.collapse;
    } else {
      this.menuState = this.expended;
    }
    this.isCollapse = !this.isCollapse;
  }

}
