import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { DocumentationServicesComponent } from '../documentation-services/documentation-services.component';
import { DocumentationRoutingModule } from './documentation-routing.module';
import { DocumentationPresentationComponent } from '../documentation-presentation/documentation-presentation.component';
import { DocumentationApiComponent } from '../documentation-api/documentation-api.component';
import { DocumentationCommercantComponent } from '../documentation-commercant/documentation-commercant.component';
import { DocumentationParticulierComponent } from '../documentation-particulier/documentation-particulier.component';

@NgModule({
  declarations: [
    DocumentationPresentationComponent,
    DocumentationServicesComponent,
    DocumentationApiComponent,
    DocumentationCommercantComponent,
    DocumentationParticulierComponent
  ],
  imports: [
    CommonModule,
    DocumentationRoutingModule,
  ],
})
export class DocumentationModule {}
