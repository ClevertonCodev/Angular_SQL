import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PostListComponent } from './post-list/post-list.component';
import { PostDetailsComponent } from './post-details/post-details.component';

const routes: Routes = [
  { path: '',
  component: PostListComponent,
  data: { title: 'Pagina Pots' }
},
  { path: 'post/:id',
  component: PostDetailsComponent,
  data: { title: 'Pagina Detalhes' }
 }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
