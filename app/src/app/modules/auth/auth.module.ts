import { MatIconModule } from '@angular/material/icon';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { RegisterClientComponent } from './../../pages/auth/register-client/register-client.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AuthRoutingModule } from './auth-routing.module';
import { AuthComponent } from './auth.component';
import { LoginComponent } from 'src/app/pages/auth/login/login.component';
import { RegisterComponent } from 'src/app/pages/auth/register/register.component';
import { RegisterCommercantComponent } from 'src/app/pages/auth/register-commercant/register-commercant.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { NzIconModule } from 'ng-zorro-antd/icon';
import { NgNumericKeyboardModule } from 'ng-numeric-keyboard';
import { NzFormModule } from "ng-zorro-antd/form";
import { SharedModule } from 'src/app/shared/shared.module';



@NgModule({
  declarations: [
    AuthComponent,
    LoginComponent,
    RegisterComponent,
    RegisterClientComponent,
    RegisterCommercantComponent,
  ],
  imports: [
    CommonModule,
    AuthRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    NzButtonModule,
    NzNotificationModule,
    NzIconModule,
    MatIconModule,
    NgNumericKeyboardModule,
    NzFormModule,
    SharedModule
  ],
})
export class AuthModule {}
