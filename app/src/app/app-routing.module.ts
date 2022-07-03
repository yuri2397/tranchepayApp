import { PayementErrorComponent } from './shared/component/payement-error/payement-error.component';
import { PayementSuccessComponent } from './shared/component/payement-success/payement-success.component';
import { DocsComponent } from './modules/docs/docs.component';
import { ClientComponent } from './modules/client/client.component';
import { SetClientPinComponent } from './pages/auth/set-client-pin/set-client-pin.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './guard/auth.guard';
import { ClientGuard } from './guard/client.guard';
import { CommercantGuard } from './guard/commercant.guard';
import { CommercantComponent } from './modules/commercant/commercant.component';
import { ViewComponent } from './modules/view/view.component';
import { CancelPaymentComponent } from './pages/client/cancel-payment/cancel-payment.component';
import { ReturnPaymentComponent } from './pages/client/return-payment/return-payment.component';
import { PageNotFoundComponent } from './shared/component/page-not-found/page-not-found.component';
import { UnauthorizationComponent } from './shared/component/unauthorization/unauthorization.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  {
    path: 'client-code-pin',
    component: SetClientPinComponent,
  },
  {
    path: 'home',
    component: ViewComponent,
    children: [
      {
        path: '',
        loadChildren: () =>
          import('./modules/view/view.module').then((m) => m.ViewModule),
      },
    ],
  },
  {
    path: 'commercant',
    component: CommercantComponent,
    children: [
      {
        path: '',
        loadChildren: () =>
          import('./modules/commercant/commercant.module').then(
            (m) => m.CommercantModule
          ),
        canActivate: [AuthGuard, CommercantGuard],
      },
    ],
  },
  {
    path: 'auth',
    loadChildren: () =>
      import('./modules/auth/auth.module').then((m) => m.AuthModule),
  },
  {
    path: 'docs',
    component: DocsComponent,
    children: [
      {
        path: '',
        loadChildren: () =>
          import('./modules/docs/docs.module').then((m) => m.DocsModule),
      },
    ],
  },
  {
    path: 'client',
    component: ClientComponent,
    children: [
      {
        path: '',
        loadChildren: () =>
          import('./modules/client/client.module').then((m) => m.ClientModule),
      },
    ],
    canActivate: [AuthGuard, ClientGuard],
  },
  { path: 'unauthorization', component: UnauthorizationComponent },
  { path: 'cancel_payment', component: CancelPaymentComponent },
  { path: 'return_payment', component: ReturnPaymentComponent },
  { path: 'payement_success', component: PayementSuccessComponent },
  { path: 'payement_error', component: PayementErrorComponent },
  {
    path: '**',
    component: PageNotFoundComponent,
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
