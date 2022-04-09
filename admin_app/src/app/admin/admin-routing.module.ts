import { DetailsCommandeComponent } from './../pages/details-commande/details-commande.component';
import { DetailsCommercantComponent } from './../pages/details-commercant/details-commercant.component';
import { DetailsClientsComponent } from './../pages/details-clients/details-clients.component';
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
import { AuthGuard } from '../guard/auth.guard';
import { ProfileComponent } from '../pages/profile/profile.component';

const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'clients', component: ClientComponent, canActivate: [AuthGuard] },
  {
    path: 'commercant',
    component: CommercantComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'commandes',
    component: CommandesComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'commandes-livres',
    component: CommandesLivresComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'commandes-encours',
    component: CommandesEncoursComponent,
  },
  { path: 'user',
    component: UsersComponent
   },
   { path: 'user/show/:id',
   component: ProfileComponent
  },

  {
    path: 'detailclient/:id',
    component: DetailsClientsComponent,
  },
  {
    path: 'commercant/show/:id',
    component: DetailsCommercantComponent,
  },
  {
    path: 'clients/show/:id',
    component: DetailsClientsComponent,
  },

  {
    path: 'commandes/show/:id',
    component: DetailsCommandeComponent,
  },
  {
    path: 'commandes-livres/show/:id',
    component: DetailsCommandeComponent,
  },
  {
    path: 'commandes-encours/show/:id',
    component: DetailsCommandeComponent,
  },
  {
    path: 'profile',
    component: ProfileComponent,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRoutingModule {}
