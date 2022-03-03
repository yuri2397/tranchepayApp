import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientComponent } from 'src/app/shared/component/client/client.component';
import { CommercantComponent } from 'src/app/shared/component/commercant/commercant.component';
import { ContactComponent } from 'src/app/shared/component/contact/contact.component';
import { DocumentationComponent } from 'src/app/shared/component/documentation/documentation.component';
import { IndexComponent } from 'src/app/shared/component/index/index.component';
import { ViewComponent } from './view.component';

const routes: Routes = [
  { path: '', component: IndexComponent },
  { path: 'page-commercant', component: CommercantComponent },
  { path: 'page-client', component: ClientComponent },
  { path: 'page-contact', component: ContactComponent },
  { path: 'page-documentation', component: DocumentationComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ViewRoutingModule {}
