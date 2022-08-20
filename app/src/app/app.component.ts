import { AlertModalComponent } from './shared/alert-modal/alert-modal.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Component, HostListener, OnInit } from '@angular/core';
import { Notification } from './models/notification';
import { NotificationService } from './shared/notification.service';
import { AuthService } from './services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  title = 'app';
  logout: boolean = false;
  constructor(
    private notification: NotificationService,
    private modal: NzModalService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.notification.changeEmitted$.subscribe((data: Notification) => {
      this.showModal(data);
    });
    
    this.notification.logout$.subscribe((data) => {
      
      setTimeout(() => {
        this.goOut();
      }, 600);
    });
  }

  goOut() {
    if (this.logout) {
      this.authService.logout();
      this.router.navigate(['/auth']);
    } else {
      this.logout = true;

      setTimeout(this.goOut, 600);
    }
  }

  @HostListener('document:keydown', ['$event'])
  handleKeyboardEvent(event: KeyboardEvent) {
    this.resetTimeOut();
  }

  @HostListener('click', ['$event'])
  handleClickEvent(event: KeyboardEvent) {
    this.resetTimeOut();
  }

  @HostListener('mouseup', ['$event'])
  onMouseup() {
    this.resetTimeOut();
  }

  @HostListener('mousemove', ['$event'])
  onMousemove(event: MouseEvent) {
    this.resetTimeOut();
  }

  resetTimeOut() {
    this.logout = false;
  }

  @HostListener('mousedown', ['$event'])
  onMousedown(event: any) {}

  private showModal(data: Notification) {
    this.modal.create({
      nzTitle: '',
      nzContent: AlertModalComponent,
      nzCentered: true,
      nzFooter: null,
      nzComponentParams: {
        notification: data,
      },
      nzClosable: false,
      nzBodyStyle: {
        padding: '0px',
      },
    });
  }
}
