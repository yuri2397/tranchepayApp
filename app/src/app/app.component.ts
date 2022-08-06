import { AlertModalComponent } from './shared/alert-modal/alert-modal.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Component, OnInit } from '@angular/core';
import { Notification } from './models/notification';
import { NotificationService } from './shared/notification.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  title = 'app';
  constructor(private notification: NotificationService, private modal: NzModalService) {}
  ngOnInit(): void {
    this.notification.changeEmitted$.subscribe((data: Notification) => {
      this.showModal(data);
    });
  }


  private showModal(data: Notification) {
    this.modal.create({
      nzTitle: '',
      nzContent: AlertModalComponent,
      nzCentered: true,
      nzFooter: null,
      nzComponentParams: {
        notification: data
      },
      nzClosable: false,
      nzBodyStyle:{
        padding: '0px'
      }
      
    })
  }
}
