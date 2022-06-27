import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from 'src/app/shared/component/client/client.component';
import { CommercantComponent } from 'src/app/shared/component/commercant/commercant.component';
import { ContactComponent } from 'src/app/shared/component/contact/contact.component';
import { DocumentationApiComponent } from 'src/app/shared/component/documentation-api/documentation-api.component';
import { DocumentationCommercantComponent } from 'src/app/shared/component/documentation-commercant/documentation-commercant.component';
import { DocumentationParticulierComponent } from 'src/app/shared/component/documentation-particulier/documentation-particulier.component';
import { DocumentationServicesComponent } from 'src/app/shared/component/documentation-services/documentation-services.component';
import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { IndexComponent } from 'src/app/shared/component/index/index.component';
import { ViewComponent } from './view.component';

const routes: Routes = [
  { path: '', component: IndexComponent },
  { path: 'page-commercant', component: CommercantComponent },
  { path: 'page-client', component: ClientComponent },
  { path: 'page-contact', component: ContactComponent },
  { path: 'page-documentation', component: DocumentationComponent },
  { path: 'page-documentation-services', component: DocumentationServicesComponent },
  { path: 'page-documentation-api', component: DocumentationApiComponent },
  { path: 'page-documentation-commercant', component: DocumentationCommercantComponent },
  { path: 'page-documentation-particulier', component: DocumentationParticulierComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ViewRoutingModule {}
