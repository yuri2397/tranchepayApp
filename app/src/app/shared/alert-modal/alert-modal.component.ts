import { Component, Input, OnInit } from '@angular/core';
import { NzModalRef } from 'ng-zorro-antd/modal';
import { Notification } from 'src/app/models/notification';

@Component({
  selector: 'app-alert-modal',
  templateUrl: './alert-modal.component.html',
  styleUrls: ['./alert-modal.component.scss'],
})
export class AlertModalComponent implements OnInit {
  @Input('notification') notification!: Notification;

  ngOnInit(): void {
    console.log(this.notification);
  }

  constructor(private ref: NzModalRef) {}

  close(data: any) {
    this.ref.destroy(data);
  }

  downloadFacture() {
    this.close({ download: true });
  }
}
