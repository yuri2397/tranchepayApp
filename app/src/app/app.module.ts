import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDropDownModule } from 'ng-zorro-antd/dropdown';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NZ_I18N } from 'ng-zorro-antd/i18n';
import { fr_FR } from 'ng-zorro-antd/i18n';
import { registerLocaleData } from '@angular/common';
import fr from '@angular/common/locales/fr';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SharedModule } from './shared/shared.module';
import { PageNotFoundComponent } from './shared/component/page-not-found/page-not-found.component';
import { NzResultModule } from 'ng-zorro-antd/result';
import { UnauthorizationComponent } from './shared/component/unauthorization/unauthorization.component';
import { CancelPaymentComponent } from './pages/client/cancel-payment/cancel-payment.component';
import { ReturnPaymentComponent } from './pages/client/return-payment/return-payment.component';
import { SetClientPinComponent } from './pages/auth/set-client-pin/set-client-pin.component';
import { PartenairesComponent } from './shared/component/partenaires/partenaires.component';
import { ServiceClientComponent } from './shared/component/service-client/service-client.component';
import { DashboardComponent } from './pages/client/dashboard/dashboard.component';
import { UpdatePhoneNumberComponent } from './pages/client/securite/update-phone-number/update-phone-number.component';
import { UpdatePasswordComponent } from './pages/client/securite/update-password/update-password.component';
// import { DocsModule } from './modules/docs/docs.module';

registerLocaleData(fr);

@NgModule({
  declarations: [
    AppComponent,
    PageNotFoundComponent,
    UnauthorizationComponent,
    UnauthorizationComponent,
    CancelPaymentComponent,
    ReturnPaymentComponent,
    SetClientPinComponent,
    PartenairesComponent,
    ServiceClientComponent,
    UpdatePhoneNumberComponent,
    UpdatePasswordComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    SharedModule,
    BrowserAnimationsModule,
    NzDropDownModule,
    NzResultModule,
    NzButtonModule,
    ReactiveFormsModule,
    NzNotificationModule,
    NzSkeletonModule,
    // DocsModule
  ],
  providers: [{ provide: NZ_I18N, useValue: fr_FR }],
  bootstrap: [AppComponent],
})
export class AppModule { }
