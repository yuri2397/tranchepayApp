import { FormsModule } from '@angular/forms';
import { CommandesEncoursComponent } from './../pages/commandes-encours/commandes-encours.component';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDropDownModule } from 'ng-zorro-antd/dropdown';
import { NzListModule } from 'ng-zorro-antd/list';
import { NgModule } from '@angular/core';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzBadgeModule } from 'ng-zorro-antd/badge';
import { CommonModule } from '@angular/common';
import { NzTableModule } from 'ng-zorro-antd/table';
import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { ClientComponent } from '../pages/client/client.component';
import { CommandesComponent } from '../pages/commandes/commandes.component';
import { CommercantComponent } from '../pages/commercant/commercant.component';
import { DashboardComponent } from '../pages/dashboard/dashboard.component';
import { LoginComponent } from '../pages/login/login.component';
import { ParametreComponent } from '../pages/parametre/parametre.component';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { ProfileComponent } from '../pages/profile/profile.component';
import { UsersComponent } from '../pages/users/users.component';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { CommandesLivresComponent } from '../pages/commandes-livres/commandes-livres.component';
import { DetailsClientsComponent } from '../pages/details-clients/details-clients.component';
import { DetailsCommercantComponent } from '../pages/details-commercant/details-commercant.component';
import { NzTagModule } from 'ng-zorro-antd/tag';
import { DetailsCommandeComponent } from '../pages/details-commande/details-commande.component';

@NgModule({
  declarations: [
    AdminComponent,
    DashboardComponent,
    ProfileComponent,
    ClientComponent,
    CommercantComponent,
    UsersComponent,
    ParametreComponent,
    CommandesComponent,
    CommandesLivresComponent,
    CommandesEncoursComponent,
    DetailsClientsComponent,
    DetailsCommercantComponent,
    DetailsCommandeComponent,

  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    NzDropDownModule,
    NzButtonModule,
    NzIconModule,
    NzTableModule,
    NzBadgeModule,
    NzFormModule,
    FormsModule,
    NzTagModule,
    NzListModule,
    NzDividerModule,
    NzSkeletonModule

  ]
})
export class AdminModule { }
