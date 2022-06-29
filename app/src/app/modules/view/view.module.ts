import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { ReactiveFormsModule } from '@angular/forms';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { MatIconModule } from '@angular/material/icon';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ViewRoutingModule } from './view-routing.module';
import { ViewComponent } from './view.component';
import { ContactComponent } from 'src/app/shared/component/contact/contact.component';
// import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { IndexComponent } from 'src/app/shared/component/index/index.component';
import { ClientComponent } from 'src/app/shared/component/client/client.component';
import { CommercantComponent } from 'src/app/shared/component/commercant/commercant.component';
import { NzIconModule } from 'ng-zorro-antd/icon';

@NgModule({
  declarations: [
    ViewComponent,
    // DocumentationComponent,
    IndexComponent,
    ContactComponent,
    ClientComponent,
    CommercantComponent,
  ],
  imports: [
    CommonModule,
    ViewRoutingModule,
    MatIconModule,
    NzIconModule,
    NzButtonModule,
    NzFormModule,
    ReactiveFormsModule,
    NzNotificationModule,
  ],
})
export class ViewModule {}
