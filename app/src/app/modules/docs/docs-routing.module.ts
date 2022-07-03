import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DocsApiComponent } from 'src/app/pages/docs/docs-api/docs-api.component';
import { DocsCommercantComponent } from 'src/app/pages/docs/docs-commercant/docs-commercant.component';
import { DocsParticulierComponent } from 'src/app/pages/docs/docs-particulier/docs-particulier.component';
import { DocsPresentationComponent } from 'src/app/pages/docs/docs-presentation/docs-presentation.component';
import { DocsServicesComponent } from 'src/app/pages/docs/docs-services/docs-services.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'presentation' },
  { path: 'presentation', component: DocsPresentationComponent },
  { path: 'services', component: DocsServicesComponent },
  { path: 'api', component: DocsApiComponent },
  { path: 'commercant', component: DocsCommercantComponent },
  { path: 'particulier', component: DocsParticulierComponent },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocsRoutingModule { }
