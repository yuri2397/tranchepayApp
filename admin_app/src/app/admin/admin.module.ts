import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommandesEncoursComponent } from './../pages/commandes-encours/commandes-encours.component';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDropDownModule } from 'ng-zorro-antd/dropdown';
import { NzListModule } from 'ng-zorro-antd/list';
import { NzPopconfirmModule } from 'ng-zorro-antd/popconfirm';
import { NgModule } from '@angular/core';

import { NzFormModule } from 'ng-zorro-antd/form';
import { NzBadgeModule } from 'ng-zorro-antd/badge';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { CommonModule } from '@angular/common';
import { NzTableModule } from 'ng-zorro-antd/table';
import { AdminRoutingModule } from './admin-routing.module';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { AdminComponent } from './admin.component';
import { ClientComponent } from '../pages/client/client.component';
import { CommandesComponent } from '../pages/commandes/commandes.component';
import { CommercantComponent } from '../pages/commercant/commercant.component';
import { DashboardComponent } from '../pages/dashboard/dashboard.component';
import { LoginComponent } from '../pages/login/login.component';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { ProfileComponent } from '../pages/profile/profile.component';
import { UsersComponent } from '../pages/users/users.component';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { CommandesLivresComponent } from '../pages/commandes-livres/commandes-livres.component';
import { DetailsClientsComponent } from '../pages/details-clients/details-clients.component';
import { DetailsCommercantComponent } from '../pages/details-commercant/details-commercant.component';
import { NzTagModule } from 'ng-zorro-antd/tag';
import { NzLayoutModule } from 'ng-zorro-antd/layout';
import { DetailsCommandeComponent } from '../pages/details-commande/details-commande.component';
import { ShowAdminComponent } from '../pages/show-admin/show-admin.component';
import { PartenaireListComponent } from '../pages/partenaire/partenaire-list/partenaire-list.component';
import { PartenaireCreateComponent } from '../pages/partenaire/partenaire-create/partenaire-create.component';
import { PartenaireEditComponent } from '../pages/partenaire/partenaire-edit/partenaire-edit.component';
import { NzPageHeaderModule } from 'ng-zorro-antd/page-header';
import { ParametresListComponent } from '../pages/parametre/parametres-list/parametres-list.component';
import { ParametresEditComponent } from '../pages/parametre/parametres-edit/parametres-edit.component';

@NgModule({
  declarations: [
    AdminComponent,
    DashboardComponent,
    ProfileComponent,
    ClientComponent,
    CommercantComponent,
    UsersComponent,
    CommandesComponent,
    CommandesLivresComponent,
    CommandesEncoursComponent,
    DetailsClientsComponent,
    DetailsCommercantComponent,
    DetailsCommandeComponent,
    ShowAdminComponent,
    PartenaireListComponent,
    PartenaireCreateComponent,
    PartenaireEditComponent,
    ParametresListComponent,
    ParametresEditComponent,
  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    NzDropDownModule,
    ReactiveFormsModule,
    NzButtonModule,
    NzIconModule,
    NzTableModule,
    NzBadgeModule,
    NzFormModule,
    FormsModule,
    NzTagModule,
    NzListModule,
    NzDividerModule,
    NzSkeletonModule,
    NzModalModule,
    NzInputModule,
    NzSelectModule,
    NzLayoutModule,
    NzPopconfirmModule,NzPageHeaderModule
  ]
})
export class AdminModule { }
