import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { DocumentationServicesComponent } from '../documentation-services/documentation-services.component';
import { DocumentationRoutingModule } from './documentation-routing.module';

@NgModule({
  declarations: [
    DocumentationServicesComponent,
  ],
  imports: [
    CommonModule,
    DocumentationRoutingModule,
  ],
})
export class DocumentationModule {}
