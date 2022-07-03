import { SharedModule } from './../../shared/shared.module';
import { NzStepsModule } from 'ng-zorro-antd/steps';
import { RetraitComponent } from './../../pages/commercant/retrait/retrait.component';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { AppModule } from './../../app.module';
import { AideComponent } from './../../pages/commercant/aide/aide.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DashboardComponent } from './../../pages/commercant/dashboard/dashboard.component';
import { ParrainagesComponent } from './../../pages/commercant/parrainages/parrainages.component';
import { ConditionsComponent } from './../../pages/commercant/conditions/conditions.component';
import { ApiComponent } from './../../pages/commercant/api/api.component';
import { UtilisateursComponent } from './../../pages/commercant/utilisateurs/utilisateurs.component';
// import { ParametresComponent } from './../../pages/commercant/parametres/parametres.component';
import { ComptabiliteComponent } from './../../pages/commercant/comptabilite/comptabilite.component';
import { SoldesComponent } from './../../pages/commercant/soldes/soldes.component';
import { VentesComponent } from './../../pages/commercant/ventes/ventes.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CommercantRoutingModule } from './commercant-routing.module';
import { CommercantComponent } from './commercant.component';
import { NzLayoutModule } from 'ng-zorro-antd/layout';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { MatIconModule } from '@angular/material/icon';
import { NzDropDownModule } from 'ng-zorro-antd/dropdown';
import { NzToolTipModule } from 'ng-zorro-antd/tooltip';
import { NzCardModule } from 'ng-zorro-antd/card';
import { NzTableModule } from 'ng-zorro-antd/table';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzTabsModule } from 'ng-zorro-antd/tabs';
import { MatButtonModule } from '@angular/material/button';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzAlertModule } from 'ng-zorro-antd/alert';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzListModule } from 'ng-zorro-antd/list';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { NzTagModule } from 'ng-zorro-antd/tag';
import { NzPageHeaderModule } from 'ng-zorro-antd/page-header';
import { AjouterVentesComponent } from 'src/app/pages/commercant/ventes/ajouter-ventes/ajouter-ventes.component';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzDrawerModule } from 'ng-zorro-antd/drawer';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { NzRadioModule } from 'ng-zorro-antd/radio';
import { ProfileComponent } from '../../pages/commercant/profile/profile.component';
@NgModule({
  declarations: [
    CommercantComponent,
    DashboardComponent,
    VentesComponent,
    SoldesComponent,
    UtilisateursComponent,
    ApiComponent,
    ConditionsComponent,
    ParrainagesComponent,
    AideComponent,
    AjouterVentesComponent,
    RetraitComponent,
    ProfileComponent,

  ],
  imports: [
    CommercantRoutingModule,
    SharedModule,
  ],
})
export class CommercantModule { }
