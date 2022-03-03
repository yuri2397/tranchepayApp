import { Router } from '@angular/router';
import { AuthService } from './../../../services/auth.service';
import { ClientService } from './../../../services/client.service';
import { Client } from 'src/app/models/client';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  client!: Client;
  constructor(
    private clientService: ClientService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.client = this.clientService.getClient() as Client;
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/auth']);
  }
}
