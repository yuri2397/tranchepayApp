import { NzNotificationService } from 'ng-zorro-antd/notification';
import { PartenaireService } from './../../../services/partenaire.service';
import { PartenaireEditComponent } from './../partenaire-edit/partenaire-edit.component';
import { PartenaireCreateComponent } from './../partenaire-create/partenaire-create.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Component, OnInit } from '@angular/core';
import { Partenaire } from 'src/app/models/partenaire';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-partenaire-list',
  templateUrl: './partenaire-list.component.html',
  styleUrls: ['./partenaire-list.component.scss'],
})
export class PartenaireListComponent implements OnInit {
  data!: Partenaire[];
  isload: boolean = false;

  constructor(
    private pService: PartenaireService,
    private modal: NzModalService,
    private notification: NzNotificationService
  ) {}

  ngOnInit(): void {
    this.getData();
  }
  getData() {
    this.isload = true;
    this.pService.all().subscribe({
      next: (data) => {
        this.data = data;
        this.isload = false;
      },
      error: (errors) => {
        console.log(errors);
        this.isload = false;
      },
    });
  }

  add() {
    this.modal
      .create({
        nzTitle: 'Ajouter un partenaire',
        nzContent: PartenaireCreateComponent,
        nzWidth: '600px',
        nzCentered: true,
        nzMaskClosable: false,
      })
      .afterClose.subscribe((data: Partenaire | null) => {
        if (data) {
          this.notification.success(
            'Notification',
            'Partenaire ajouter avec succès.'
          );
          this.getData();
        }
      });
  }

  del(p: Partenaire) {
    this.isload = true;
    this.pService.remove(p).subscribe({
      next: (response) => {
        this.notification.success(
          'Notification',
          'Partenaire supprimé avec succès.'
        );
        this.getData();
      },
      error: (error) => {
        console.log(error);
        this.isload = false;
      },
    });
  }

  edit(p: Partenaire) {
    this.modal
      .create({
        nzTitle: 'Modifier un partenaire',
        nzContent: PartenaireEditComponent,
        nzWidth: '600px',
        nzComponentParams: {
          partenaire: JSON.parse(JSON.stringify(p)) as Partenaire,
        },
        nzCentered: true,
        nzMaskClosable: false,
      })
      .afterClose.subscribe((data: Partenaire | null) => {
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
