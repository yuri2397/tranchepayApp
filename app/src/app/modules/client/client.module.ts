import { SharedModule } from './../../shared/shared.module';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { SecuriteComponent } from './../../pages/client/securite/securite.component';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

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
import { NzTagModule } from 'ng-zorro-antd/tag';
import { NzPageHeaderModule } from 'ng-zorro-antd/page-header';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzDrawerModule } from 'ng-zorro-antd/drawer';
import { NzGridModule } from 'ng-zorro-antd/grid';
import { CreateClientComponent } from 'src/app/pages/client/create-client/create-client.component';
import { ClientRoutingModule } from './client-routing.module';
import { ClientComponent } from './client.component';
import { CommandesComponent } from '../../pages/client/commandes/commandes.component';
import { VersementCreateComponent } from '../../pages/client/versement-create/versement-create.component';
import { VersementListComponent } from '../../pages/client/versement-list/versement-list.component';
import { DeplafonnementComponent } from '../../pages/client/deplafonnement/deplafonnement.component';
import { DemandeFinancementComponent } from '../../pages/client/demande-financement/demande-financement.component';
import { CoordonneesComponent } from '../../pages/client/coordonnees/coordonnees.component';
import { ProfileComponent } from '../../pages/client/profile/profile.component';
import { ConfirmePayementComponent } from '../../pages/client/confirme-payement/confirme-payement.component';

@NgModule({
  declarations: [
    ClientComponent,
    CreateClientComponent,
    CommandesComponent,
    VersementCreateComponent,
    VersementListComponent,
    DeplafonnementComponent,
    DemandeFinancementComponent,
    CoordonneesComponent,
    ProfileComponent,
    ConfirmePayementComponent,
  ],
  imports: [ClientRoutingModule, SharedModule],
})
export class ClientModule {}
