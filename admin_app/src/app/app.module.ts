import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { NzSkeletonModule } from 'ng-zorro-antd/skeleton';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzDropDownModule } from 'ng-zorro-antd/dropdown';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { LoginComponent } from './pages/login/login.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { ClientComponent } from './pages/client/client.component';
import { CommercantComponent } from './pages/commercant/commercant.component';
import { UsersComponent } from './pages/users/users.component';
import { ParametreComponent } from './pages/parametre/parametre.component';
import { CommandesComponent } from './pages/commandes/commandes.component';
import { NZ_I18N } from 'ng-zorro-antd/i18n';
import { fr_FR } from 'ng-zorro-antd/i18n';
import { registerLocaleData } from '@angular/common';
import fr from '@angular/common/locales/fr';
import { HttpClientModule } from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { CommandesLivresComponent } from './pages/commandes-livres/commandes-livres.component';
import { CommandesEncoursComponent } from './pages/commandes-encours/commandes-encours.component';

registerLocaleData(fr);

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    NzSkeletonModule,
    NzNotificationModule,
    NzButtonModule,
    NzDropDownModule,
    ReactiveFormsModule,


  ],
  providers: [{ provide: NZ_I18N, useValue: fr_FR }],
  bootstrap: [AppComponent]
})
export class AppModule { }
