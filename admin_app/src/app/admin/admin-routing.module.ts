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

const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard/:email', component: DashboardComponent

  },
  { path: 'clients',
      component: ClientComponent,
      canActivate:[AuthGuard],

   },
  { path: 'commercant',
      component: CommercantComponent ,
      canActivate:[AuthGuard],
  },
  { path: 'commandes',
      component: CommandesComponent,
      canActivate:[AuthGuard]
    },
  { path: 'commandes-livres',
      component: CommandesLivresComponent,
      canActivate:[AuthGuard]
    },
  { path: 'commandes-encours',
  component:CommandesEncoursComponent,
  canActivate:[AuthGuard],

  },
  { path: 'user',
    component: UsersComponent,
    canActivate:[AuthGuard],

  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRoutingModule {}
