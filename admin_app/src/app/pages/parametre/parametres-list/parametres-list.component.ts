import { NzModalService } from 'ng-zorro-antd/modal';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { Component, OnInit } from '@angular/core';
import { ModePayement, Param } from 'src/app/models/param';
import { ParamsService } from 'src/app/services/params.service';
import { ParametresEditComponent } from '../parametres-edit/parametres-edit.component';

@Component({
  selector: 'app-parametres-list',
  templateUrl: './parametres-list.component.html',
  styleUrls: ['./parametres-list.component.scss'],
})
export class ParametresListComponent implements OnInit {
  isLoad = false;
  data!: Param[];
  isLoad1 = false;
  modePayements!: ModePayement[];

  constructor(
    private paramsService: ParamsService,
    private notification: NzNotificationService,
    private modal: NzModalService
  ) {}

  ngOnInit(): void {
    this.getData();
  }
  getData() {
    this.isLoad = true;
    this.paramsService.all().subscribe({
      next: (response) => {
        this.data = response;
        console.log(this.data);
        this.paramsService.modePayement().subscribe((data) => {
          this.modePayements = data;
          this.isLoad = false;
        });
      },
      error: (error) => {
        console.log(error);
        this.isLoad = false;
      },
    });
  }

  edit(p: Param) {
    this.modal
      .create({
        nzTitle: 'Modification',
        nzContent: ParametresEditComponent,
        nzWidth: '600px',
        nzComponentParams: {
          param: JSON.parse(JSON.stringify(p)) as Param,
        },
        nzCentered: true,
        nzMaskClosable: false,
      })
      .afterClose.subscribe((data: Param | null) => {
        if (data) {
          this.notification.success(
            'Notification',
            'Partenaire ajouter avec succès.'
          );
          this.getData();
        }
      });
  }

  editMode(m: ModePayement) {
    this.modal
      .create({
        nzTitle: 'Modification',
        nzContent: ParametresEditComponent,
        nzWidth: '600px',
        nzComponentParams: {
          mode: JSON.parse(JSON.stringify(m)) as ModePayement,
        },
        nzCentered: true,
        nzMaskClosable: false,
      })
      .afterClose.subscribe((data: Param | null) => {
        if (data) {
          this.notification.success(
            'Notification',
            'Partenaire ajouter avec succès.'
          );
          this.getData();
        }
      });
  }
}
