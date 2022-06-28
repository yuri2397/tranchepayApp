import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { DocumentationServicesComponent } from '../documentation-services/documentation-services.component';
import { DocumentationRoutingModule } from './documentation-routing.module';
import { DocumentationApiComponent } from '../documentation-api/documentation-api.component';
import { DocumentationCommercantComponent } from '../documentation-commercant/documentation-commercant.component';
import { DocumentationParticulierComponent } from '../documentation-particulier/documentation-particulier.component';
import { DocumentationPresentationComponent } from '../documentation-presentation/documentation-presentation.component';

@NgModule({
  declarations: [
    DocumentationServicesComponent,
    DocumentationApiComponent,
    DocumentationCommercantComponent,
    DocumentationParticulierComponent,
    DocumentationPresentationComponent,
  ],
  imports: [CommonModule, DocumentationRoutingModule],
})
export class DocumentationModule {}
