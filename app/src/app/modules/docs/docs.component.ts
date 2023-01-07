import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service'
import { Component, OnInit } from '@angular/core'

@Component({
  selector: 'app-docs',
  templateUrl: './docs.component.html',
  styleUrls: ['./docs.component.scss'],
})
export class DocsComponent implements OnInit {
  currentYear: any
  user_type = '';

  constructor(public authService: AuthService,private router: Router) {}

  ngOnInit(): void {
    this.user_type = this.authService.getUser().model_type.toLocaleLowerCase();
    this.currentYear = new Date().getFullYear()
  }

  selected(data: string){
    if(this.router.url.indexOf(data) != -1){
      return true;
    }

    return false;
  }
}
