import { Subject } from 'rxjs';
import { Injectable } from '@angular/core';
import { Notification } from '../models/notification';

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  // Observable string sources
  private emitChangeSource = new Subject<Notification>();
  // Observable string streams
  changeEmitted$ = this.emitChangeSource.asObservable();
  // Service message commands
  emitChange(change: Notification) {
      this.emitChangeSource.next(change);
  }
}
