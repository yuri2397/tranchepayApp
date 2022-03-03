import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from '../pages/client/client.component';
import { CommandesComponent } from '../pages/commandes/commandes.component';
import { CommercantComponent } from '../pages/commercant/commercant.component';
import { DashboardComponent } from '../pages/dashboard/dashboard.component';
import { AdminComponent } from './admin.component';

const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'clients', component: ClientComponent },
  { path: 'commercant', component: CommercantComponent },
  { path: 'commandes', component: CommandesComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRoutingModule {}
