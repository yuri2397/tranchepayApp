import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

declare interface RouteInfo {
  path: string;
  title: string;
  icon: string;
  class: string;
  roles: string[];
}

export const ROUTES: RouteInfo[] = [
  {
    path: 'accueil',
    title: 'Tableau de   bord',
    icon: 'dot-chart',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'ventes',
    title: 'Listes des ventes',
    icon: 'shopping',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'soldes',
    title: 'Solde',
    icon: 'dollar-circle',
    class: '',
    roles: ['super admin'],
  },
  
  {
    path: 'utilisateurs',
    title: 'Utilisateurs',
    icon: 'user',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'api',
    title: 'API',
    icon: 'link',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'conditions',
    title: 'Conditions',
    icon: 'safety-certificate',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'parrainages',
    title: 'Parrainages',
    icon: 'rocket',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'aide',
    title: 'Services client',
    icon: 'question-circle',
    class: '',
    roles: ['super admin'],
  },
  {
    path: 'parametres',
    title: 'Paramétres',
    icon: 'setting',
    class: '',
    roles: ['super admin'],
  },
];

@Component({
  selector: 'app-commercant',
  templateUrl: './commercant.component.html',
  styleUrls: ['./commercant.component.scss'],
})
export class CommercantComponent implements OnInit {
  isCollapsed = false;
  menuItems!: RouteInfo[];
  isLoad = false;
  title = 'TRANCHEPAY';
  constructor(private router: Router, private authService: AuthService) {}

  ngOnInit(): void {
    this.menuItems = ROUTES.filter((menuItem) => menuItem);
  }

  routerLink(item: RouteInfo) {
    this.router.navigate(['/commercant/' + item.path]);
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/auth']);
  }

  selected(item: RouteInfo) {
    return this.router.url.indexOf(item.path) !== -1 ? true : false;
  }
}
