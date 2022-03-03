import { Component, OnInit } from '@angular/core';
import { DeviceDetectorService } from 'ngx-device-detector';

declare interface MenuClass {
  navbar: string;
  icon: string;
  btnConnexion: string;
  btnInscription: string;
}

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss'],
})
export class IndexComponent implements OnInit {
  collapse: MenuClass = {
    navbar: 'navbar',
    icon: 'bi mobile-nav-toggle bi-list',
    btnConnexion: '',
    btnInscription:
      'btn btn-sm btn-new-account-home mx-3 px-2 py-1 text-white',
  };
  menuState!: MenuClass;
  expended: MenuClass = {
    navbar: 'navbar navbar-mobile',
    icon: 'bi mobile-nav-toggle bi-x',
    btnConnexion: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
    btnInscription: 'btn btn-sm btn-new-account-home my-sm-1 mx-3 px-2 py-1 text-white',
  };

  isCollapse!: boolean;
  constructor(private deviceService: DeviceDetectorService) {}

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
