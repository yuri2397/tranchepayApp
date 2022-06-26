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

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'commandes' },
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
