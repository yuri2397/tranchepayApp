import { CommandesComponent } from './pages/commandes/commandes.component';
import { CommercantComponent } from './pages/commercant/commercant.component';
import { ClientComponent } from './pages/client/client.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {path: "dashboard", component: DashboardComponent},
  {path: "clients", component: ClientComponent},
  {path: "commercant", component: CommercantComponent},
  {path: "commandes", component: CommandesComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
