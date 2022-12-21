import { UpdatePasswordComponent } from './../../pages/client/securite/update-password/update-password.component';
import { ConfirmePayementComponent } from './../../pages/client/confirme-payement/confirme-payement.component';
import { ProfileComponent } from './../../pages/client/profile/profile.component';
import { PartenairesComponent } from './../../shared/component/partenaires/partenaires.component';
import { ServiceClientComponent } from './../../shared/component/service-client/service-client.component';
import { SecuriteComponent } from './../../pages/client/securite/securite.component';
import { CoordonneesComponent } from './../../pages/client/coordonnees/coordonnees.component';
import { DemandeFinancementComponent } from './../../pages/client/demande-financement/demande-financement.component';
import { DeplafonnementComponent } from './../../pages/client/deplafonnement/deplafonnement.component';
import { VersementListComponent } from './../../pages/client/versement-list/versement-list.component';
import { VersementCreateComponent } from './../../pages/client/versement-create/versement-create.component';
import { CommandesComponent } from './../../pages/client/commandes/commandes.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from './client.component';
import { ShowComponent } from 'src/app/pages/client/commandes/show/show.component';
import { DashboardComponent } from 'src/app/pages/client/dashboard/dashboard.component';
import { UpdatePhoneNumberComponent } from 'src/app/pages/client/securite/update-phone-number/update-phone-number.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'dashboard' },
  {path: "dashboard", component: DashboardComponent},
  {path: "update-phone-number", component: UpdatePhoneNumberComponent},
  {path: "update-password", component: UpdatePasswordComponent},
  { path: 'commandes', component: CommandesComponent },
  { path: 'commandes/show/:id', component: ShowComponent },
  { path: 'versement-create', component: VersementCreateComponent },
  { path: 'versement-list', component: VersementListComponent },
  { path: 'deplafonnement', component: DeplafonnementComponent },
  { path: 'demande-financement', component: DemandeFinancementComponent },
  { path: 'coordonnees', component: ProfileComponent },
  { path: 'securite', component: SecuriteComponent },
  { path: 'service-client', component: ServiceClientComponent },
  { path: 'partenaires', component: PartenairesComponent },
  { path: 'payements', component: ConfirmePayementComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ClientRoutingModule {}
