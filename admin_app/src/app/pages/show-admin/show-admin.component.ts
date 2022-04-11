import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NzModalService } from 'ng-zorro-antd/modal';
import { Admin, Permission } from 'src/app/models/admin';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-show-admin',
  templateUrl: './show-admin.component.html',
  styleUrls: ['./show-admin.component.scss']
})
export class ShowAdminComponent implements OnInit {
  id:any;
  isLoad = true;
  admin!:Admin;
  Permissions!:Permission[];
  visibleModal = false;
  listOfOption:any;
  listOfSelectedValue!: Permission[];
  permiss!:Permission[];


    constructor(private route:ActivatedRoute,public AuthSrv:AuthService,private modal: NzModalService,    private router: Router) { }

    ngOnInit(): void {
      this.id=this.route.snapshot.paramMap.get('id');
      this.isLoad = true;
      this.AuthSrv.findAdminById(this.id).subscribe({
        next: (response) => {
          this.admin = response;
          console.log('cheikh bi'+JSON.stringify(this.admin))
          this.Permissions=this.admin.permissions;
          this.isLoad = false;
        },

        error: (errors) => {
          console.error(errors);
        },
      });

      this.findPermissions();

    }

    deleteAdmin()
    {


      this.AuthSrv.deleteAdmin(this.admin.id).subscribe({
        next: (response) => {
    console.log(response);
          this.isLoad = false;
          this.router.navigate(['/admin/user'])
        },

        error: (errors) => {
          console.error(errors);
        },
      });
    }

    showModal(): void {

      this.visibleModal = true;

    }

    handleOk(): void {
      this.admin.permissions=this.listOfSelectedValue
      this.AuthSrv.EditAdmin(this.admin.id,this.admin).subscribe({
        next: (response) => {
          console.log(response);
          this.isLoad = false;
          this.router.navigate(['/admin/user'])
        },

        error: (errors) => {
          console.error(errors);
        },
      });
      this.visibleModal = false;

    }

    handleCancel(): void {
      this.visibleModal = false;

    }
    showDeleteConfirm(): void {
      this.modal.confirm({
        nzTitle: 'Voulez vous vraiment supprimer cette permission?',
        nzOkText: 'Oui',
        nzOkType: 'primary',
        nzOkDanger: true,
        nzOnOk: () => this.deleteAdmin(),
        nzCancelText: 'Non',
        nzOnCancel: () => console.log('Cancel')
      });
    }


    findPermissions() {
      this.isLoad = true;
      this.AuthSrv.allPermissions().subscribe({
        next: (response) => {
          this.listOfOption = response;
          console.log('les Permissions aziz' + JSON.stringify(this.listOfOption));
          this.isLoad = false;
        },

        error: (errors) => {
          console.error(errors);
        },
      });
    }



}
