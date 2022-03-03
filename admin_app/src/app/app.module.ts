import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { LoginComponent } from './pages/login/login.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { ClientComponent } from './pages/client/client.component';
import { CommercantComponent } from './pages/commercant/commercant.component';
import { UsersComponent } from './pages/users/users.component';
import { ParametreComponent } from './pages/parametre/parametre.component';
import { CommandesComponent } from './pages/commandes/commandes.component';

@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    LoginComponent,
    ProfileComponent,
    ClientComponent,
    CommercantComponent,
    UsersComponent,
    ParametreComponent,
    CommandesComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
