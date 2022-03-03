import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { ClientComponent } from '../pages/client/client.component';
import { CommandesComponent } from '../pages/commandes/commandes.component';
import { CommercantComponent } from '../pages/commercant/commercant.component';
import { DashboardComponent } from '../pages/dashboard/dashboard.component';
import { LoginComponent } from '../pages/login/login.component';
import { ParametreComponent } from '../pages/parametre/parametre.component';
import { ProfileComponent } from '../pages/profile/profile.component';
import { UsersComponent } from '../pages/users/users.component';


@NgModule({
  declarations: [
    AdminComponent,
    DashboardComponent,
    ProfileComponent,
    ClientComponent,
    CommercantComponent,
    UsersComponent,
    ParametreComponent,
    CommandesComponent
  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    
  ]
})
export class AdminModule { }
