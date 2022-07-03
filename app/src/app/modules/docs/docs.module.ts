import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DocsRoutingModule } from './docs-routing.module';
import { DocsComponent } from './docs.component';
import { DocsApiComponent } from 'src/app/pages/docs/docs-api/docs-api.component';
import { DocsServicesComponent } from 'src/app/pages/docs/docs-services/docs-services.component';
import { DocsPresentationComponent } from 'src/app/pages/docs/docs-presentation/docs-presentation.component';
import { DocsParticulierComponent } from 'src/app/pages/docs/docs-particulier/docs-particulier.component';
import { DocsCommercantComponent } from 'src/app/pages/docs/docs-commercant/docs-commercant.component';

@NgModule({
  declarations: [
    DocsComponent,
    DocsApiComponent,
    DocsServicesComponent,
    DocsPresentationComponent,
    DocsParticulierComponent,
    DocsCommercantComponent,
  ],
  imports: [
    CommonModule,
    DocsRoutingModule
  ]
})
export class DocsModule { }
