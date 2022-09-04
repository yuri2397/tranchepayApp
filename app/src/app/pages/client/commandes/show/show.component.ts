import {SharedService} from './../../../../services/shared.service';
import {NzNotificationService} from 'ng-zorro-antd/notification';
import {VersementCreateComponent} from './../../versement-create/versement-create.component';
import {NzModalService} from 'ng-zorro-antd/modal';
import {Commande} from 'src/app/models/commande';
import {ActivatedRoute} from '@angular/router';
import {Component, OnInit} from '@angular/core';
import {Location} from '@angular/common';
import {CommandesService} from 'src/app/services/commandes.service';
import {PayementPaddingComponent} from 'src/app/shared/component/payement-padding/payement-padding.component';
import {NotificationService} from 'src/app/shared/notification.service';

@Component({selector: 'app-show', templateUrl: './show.component.html', styleUrls: ['./show.component.scss']})
export class ShowComponent implements OnInit {
    commande !: Commande;
    isLoad = true;

    constructor(private route : ActivatedRoute, public commandeService : CommandesService, private location : Location, private modal : NzModalService, private notification : NzNotificationService, private sharedService : SharedService, private message : NotificationService) {}

    ngOnInit(): void {
        this.route.params.subscribe((param) => {
            this.findCommande(param['id']);
        });
    }
    findCommande(id : string) {
        this.isLoad = true;
        this.commandeService.show(id).subscribe({
            next: (response) => {
                console.log(response);
                this.commande = response;
                this.isLoad = false;
            },
            error: (errors) => {
                console.log(errors);
            }
        });
    }

    openAddVersementModal() {
        this.modal.create({
            nzTitle: 'Faire un versement',
            nzContent: VersementCreateComponent,
            nzComponentParams: {
                commande: this.commande
            },
            nzCentered: true,
            nzClosable: true,
            nzWidth: '50%',
            nzMaskClosable: false,
            nzFooter: null
        }).afterClose.subscribe((data : any | null) => {

            if (data) {
                let type: any = 'info';
                let m = this.modal.create({
                    nzTitle: undefined,
                    nzFooter: null,
                    nzContent: PayementPaddingComponent,
                    nzCentered: true,
                    nzMaskClosable: false,
                    nzClosable: false,
                    nzComponentParams: {
                        text: data.message,
                        url: data.data ?. wave_launch_url ?? null,
                        load: true,
                        type: type
                    }
                });
                (async () => {
                    while (await new Promise<boolean>((resolve) => {
                        setTimeout(() => {
                            this.sharedService.checkPadding(data.padding).subscribe({
                                next: (check) => {
                                    if (check.status) {
                                        m.destroy();
                                        this.successModal('Le paiement est validé avec succès.');
                                        this.findCommande(this.commande.id as any);
                                    }
                                    resolve(!check.status);
                                },
                                error: (error) => {
                                    console.log(error);
                                    this.errorModal(error.error.message);
                                    resolve(false);
                                }
                            });
                        }, 5000);
                    })) {
                        console.log('Wait for check');
                    }
                })();
            }
        });
    }

    successModal(message : string) {
        this.modal.create({
            nzTitle: undefined,
            nzFooter: null,
            nzContent: PayementPaddingComponent,
            nzCentered: true,
            nzMaskClosable: false,
            nzClosable: true,
            nzComponentParams: {
                text: message,
                type: 'success',
                load: false
            }
        }).afterClose.subscribe(_ => this.location.back());
    }

    errorModal(message : string) {
        this.modal.create({
            nzTitle: undefined,
            nzFooter: null,
            nzContent: PayementPaddingComponent,
            nzCentered: true,
            nzMaskClosable: false,
            nzClosable: true,
            nzComponentParams: {
                text: message,
                type: 'error',
                load: false
            }
        });
    }

    etatCommande(data : Commande): string {
        let etat = '';
        switch (data.etat_commande.nom) {
            case 'append': etat = 'EN ATTENTE';
                break;
            case 'load': etat = 'EN COURS';
                break;
            case 'finish': etat = 'TERMINER';
        }
        return etat;
    }

    etatColor(data : Commande) {
        let etat = 'green';
        switch (data.etat_commande.nom) {
            case 'append': etat = 'red';
                break;
            case 'load': etat = 'gold';
                break;
        }
        return etat;
    }

    onBack() {
        this.location.back();
    }

    total(commande : Commande) {
        return(+ commande.prix_total + + commande.commission);
    }
}
