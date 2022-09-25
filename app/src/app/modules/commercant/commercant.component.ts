import { AuthService } from './../../services/auth.service'
import { Component, OnInit } from '@angular/core'
import { Router } from '@angular/router'

declare interface RouteInfo {
  path: string
  title: string
  icon: string
  class: string
  roles: string[]
  permissions: string[]
}

export const ROUTES: RouteInfo[] = [
  {
    path: 'accueil',
    title: 'Tableau de   bord',
    icon: 'dot-chart',
    class: '',
    roles: ['super admin'],
    permissions: ['administrateur'],
  },
  {
    path: '/search-client-vente',
    title: 'Ajouter une vente',
    icon: 'shopping_cart',
    class: '',
    roles: ['super admin'],
    permissions: ['administrateur'],
  },
  {
    path: 'ventes',
    title: 'Listes des ventes',
    icon: 'shopping',
    class: '',
    roles: ['super admin'],
    permissions: ['vendeur', 'administrateur'],
  },
  {
    path: 'soldes',
    title: 'Solde',
    icon: 'dollar-circle',
    class: '',
    roles: ['super admin'],
    permissions: ['administrateur'],
  },

  {
    path: 'utilisateurs',
    title: 'Utilisateurs',
    icon: 'user',
    class: '',
    roles: ['super admin'],
    permissions: ['administrateur', 'opérateur'],
  },
  {
    path: 'api',
    title: 'API',
    icon: 'link',
    class: '',
    roles: ['super admin'],
    permissions: ['administrateur'],
  },
  {
    path: 'conditions',
    title: 'Conditions',
    icon: 'safety-certificate',
    class: '',
    roles: ['super admin'],
    permissions: ['*'],
  },
  {
    path: 'parrainages',
    title: 'Parrainages',
    icon: 'rocket',
    class: '',
    roles: ['super admin'],
    permissions: ['*'],
  },
  {
    path: 'aide',
    title: 'Services client',
    icon: 'question-circle',
    class: '',
    roles: ['super admin'],
    permissions: ['*'],
  },
]

@Component({
  selector: 'app-commercant',
  templateUrl: './commercant.component.html',
  styleUrls: ['./commercant.component.scss'],
})
export class CommercantComponent implements OnInit {
  isCollapsed = false
  menuItems!: RouteInfo[]
  isLoad = false
  title = 'TRANCHEPAY'
  constructor(private router: Router, private authService: AuthService) {}

  ngOnInit(): void {
    this.menuItems = ROUTES.filter((menuItem) => menuItem)
  }

  routerLink(item: RouteInfo) {
    this.router.navigate(['/commercant/' + item.path])
  }

  logout() {
    this.authService.logout()
    this.router.navigate(['/auth'])
  }

  selected(item: RouteInfo) {
    return this.router.url.indexOf(item.path) !== -1 ? true : false
  }

  can(item: RouteInfo) {
    let r = false
    this.authService.getUser().permissions?.forEach((e) => {
      if (
        item.permissions.indexOf(e.name) != -1 ||
        item.permissions.indexOf('*') != -1
      ) {
        r = true
      }
    })
    return r
  }

  goto(value: string) {
    this.router.navigate(['/commercant/' + value])
  }
}
