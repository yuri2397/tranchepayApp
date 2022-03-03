import { RegisterClientComponent } from './../../pages/auth/register-client/register-client.component';
import { RegisterComponent } from './../../pages/auth/register/register.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from 'src/app/pages/auth/login/login.component';
import { RegisterCommercantComponent } from 'src/app/pages/auth/register-commercant/register-commercant.component';

const routes: Routes = [
  { path: '', redirectTo: 'login' },
  { path: 'login', component: LoginComponent },
  {path: 'register', component: RegisterComponent},
  {path: 'register-client', component: RegisterClientComponent},
  {path: 'register-commercant', component: RegisterCommercantComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AuthRoutingModule {}
