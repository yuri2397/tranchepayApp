import { UsersComponent } from './../pages/users/users.component';
import { CommandesEncoursComponent } from './../pages/commandes-encours/commandes-encours.component';
import { CommandesLivresComponent } from './../pages/commandes-livres/commandes-livres.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from '../pages/client/client.component';
import { CommandesComponent } from '../pages/commandes/commandes.component';
import { CommercantComponent } from '../pages/commercant/commercant.component';
import { DashboardComponent } from '../pages/dashboard/dashboard.component';
import { AdminComponent } from './admin.component';

const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard/:email', component: DashboardComponent },
  { path: 'clients', component: ClientComponent },
  { path: 'commercant', component: CommercantComponent },
  { path: 'commandes', component: CommandesComponent },
  { path: 'commandes-livres', component: CommandesLivresComponent },
  { path: 'commandes-encours', component: CommandesEncoursComponent },
  { path: 'user', component: UsersComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRoutingModule {}
