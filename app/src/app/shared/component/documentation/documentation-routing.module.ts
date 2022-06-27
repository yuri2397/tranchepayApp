import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DocumentationApiComponent } from 'src/app/shared/component/documentation-api/documentation-api.component';
import { DocumentationCommercantComponent } from 'src/app/shared/component/documentation-commercant/documentation-commercant.component';
import { DocumentationParticulierComponent } from 'src/app/shared/component/documentation-particulier/documentation-particulier.component';
import { DocumentationServicesComponent } from 'src/app/shared/component/documentation-services/documentation-services.component';

const routes: Routes = [
  { path: 'page-documentation-services', component: DocumentationServicesComponent },
  { path: 'page-documentation-api', component: DocumentationApiComponent },
  { path: 'page-documentation-commercant', component: DocumentationCommercantComponent },
  { path: 'page-documentation-particulier', component: DocumentationParticulierComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class DocumentationRoutingModule {}
