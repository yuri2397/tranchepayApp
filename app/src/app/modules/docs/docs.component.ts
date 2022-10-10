import { AuthService } from 'src/app/services/auth.service'
import { Component, OnInit } from '@angular/core'

@Component({
  selector: 'app-docs',
  templateUrl: './docs.component.html',
  styleUrls: ['./docs.component.scss'],
})
export class DocsComponent implements OnInit {
  currentYear: any

  constructor(public authService: AuthService) {}

  ngOnInit(): void {
    this.currentYear = new Date().getFullYear()
  }
}
