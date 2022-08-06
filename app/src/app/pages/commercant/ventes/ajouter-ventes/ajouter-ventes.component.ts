import { Router, ActivatedRoute } from '@angular/router';
import { PayementPaddingComponent } from './../../../../shared/component/payement-padding/payement-padding.component';
import { ModePaiement } from './../../../../models/mode-paiement';
import { SharedService } from './../../../../services/shared.service';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { CreateClientComponent } from 'src/app/pages/client/create-client/create-client.component';
import { NzModalService } from 'ng-zorro-antd/modal';
import { NzDrawerService } from 'ng-zorro-antd/drawer';
import { CommercantService } from './../../../../services/commercant.service';
import { ClientService } from './../../../../services/client.service';
import { Produit } from './../../../../models/produit';
import { Component, OnInit, SimpleChanges } from '@angular/core';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  FormGroupName,
  Validators,
} from '@angular/forms';
import { Client } from 'src/app/models/client';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
import { NotificationService } from 'src/app/shared/notification.service';
import { Location } from '@angular/common';
@Component({
  selector: 'app-ajouter-ventes',
  templateUrl: './ajouter-ventes.component.html',
  styleUrls: ['./ajouter-ventes.component.scss'],
})
export class AjouterVentesComponent implements OnInit {
  typePay!: string;
  validateForm!: FormGroup;
  payementType!: any;
  payementFormGroup!: FormGroup;
  montantTotal = 0;
  localPayementVisible = false;
  montantActuelTotal = 0;

  isLoad: boolean = false;
  produits: Produit[] = [];
  clients: Client[] = [];
  selectedClient!: Client;
  modePaiements!: ModePaiement[];
  loadClient = false;
  drawerVisible = false;
  modeLoad: boolean = false;
  isVisible = false;
  isInvisible = false;
  makeVisible = false;

  mystyle = { width: '200px', padding: '0px' };
  modePaiement = [
    {
      type_paiement: 'Paiement en caisse',
      name: 'offline',
      image_src: '/assets/img/paycash.png',
    },
    {
      type_paiement: 'Paiement en ligne',
      name: 'online',
      image_src: '/assets/img/paymobile.png',
    },
  ];
  mobilePayements = [
    {
      name: 'wave',
      choice_label: 'Payer avec Wave',
      image_src: '/assets/img/nav-logo.png',
      padding: 'p-3',
      margin_top: '0px',
    },
    {
      name: 'om',
      choice_label: 'Payer avec Orange Money',
      image_src: '/assets/img/orangemoney.png',
      padding: '5px',
      margin_top: '0px',
    },
    {
      name: 'free',
      choice_label: 'Payer avec Free Money',
      image_src: '/assets/img/freemoney.png',
      padding: '5px',
      margin_top: '-6px',
    },
  ];
  amountError: boolean = false;
  amountErrorMessage!: string;
  selectedInteret!: any;
  commission: any = 0;

  constructor(
    private domSanitizer: DomSanitizer,
    private matIconRegistry: MatIconRegistry,
    private fb: FormBuilder,
    private commercantService: CommercantService,
    private modalService: NzModalService,
    private notification: NzNotificationService,
    private sharedService: SharedService,
    private route: ActivatedRoute,
    private notificatoinService: NotificationService,
    private location: Location
  ) {
    this.matIconRegistry.addSvgIcon(
      'paycash',
      this.domSanitizer.bypassSecurityTrustResourceUrl(
        '../assets/img/paycash.svg'
      )
    );
    this.matIconRegistry.addSvgIcon(
      'payonline',
      this.domSanitizer.bypassSecurityTrustResourceUrl(
        '../assets/img/payonline.svg'
      )
    );
  }

  ngOnInit(): void {
    this.route.queryParams.subscribe((params) => {
      this.selectedClient = JSON.parse(params['customer']) as Client;
      this.getModePayement(this.selectedClient.id);
    });

    this.validateForm = this.fb.group({
      nom_produit: [null, [Validators.required]],
      quantite_produit: [null, [Validators.required, Validators.min(0)]],
      prix_unitaire_produit: [null, [Validators.required]],
    });
  }

  aPayer(): number {
    let amount = 0;
    this.produits.forEach((p) => {
      amount += p.prix_unitaire * p.quantite;
    });
    return Math.round(amount * (1 / 3));
  }

  addToList() {
    this.montantActuelTotal = 0;
    let p = new Produit();
    p.nom = this.validateForm.value.nom_produit;
    p.quantite = this.validateForm.value.quantite_produit;
    p.prix_unitaire = this.validateForm.value.prix_unitaire_produit;
    this.produits = [...this.produits, p];
    this.produits.forEach((element) => {
      this.montantActuelTotal += element.prix_unitaire * element.quantite;
    });
    this.validateForm.reset();
  }

  removeProduit(data: Produit) {
    this.produits.splice(this.produits.indexOf(data), 1);

    this.produits = [...this.produits];
  }

  total() {
    let amount = 0;
    this.produits?.forEach((p) => (amount += p.prix_unitaire * p.quantite));
    return amount;
  }

  getModePayement(client: any) {
    if (client == null) return;
    this.modeLoad = true;
    this.sharedService.modePaiement(client).subscribe({
      next: (response) => {
        console.log(response);
        this.modePaiements = response;
        this.modeLoad = false;
      },
      error: (errors) => {
        console.log(errors);
      },
    });
  }

  onClientSearch(data: string) {
    this.loadClient = true;
    if (data.length >= 5) {
      this.commercantService.findByClientTelephone(data).subscribe({
        next: (response) => {
          this.clients = response;
          this.loadClient = false;
        },
        error: (errors) => {
          console.error(errors);
          this.loadClient = false;
        },
      });
    }
  }

  saveVente(
    mode: 'online' | 'offline',
    via: 'om' | 'wave' | 'free' | 'local' = 'local'
  ) {
    this.isLoad = true;

    this.commercantService
      .createCommande(
        this.produits,
        this.selectedClient.id,
        this.payementFormGroup.value.interet,
        this.payementFormGroup.value.firstPart,
        this.payementFormGroup.value.telephone,
        this.payementType,
        via
      )
      .subscribe({
        next: (response) => {
          console.log(response);
          let type: any = 'info';
          if (mode == 'online') {
            let m = this.modalService.create({
              nzTitle: undefined,
              nzFooter: null,
              nzContent: PayementPaddingComponent,
              nzCentered: true,
              nzMaskClosable: false,
              nzClosable: false,
              nzComponentParams: {
                text: response.message,
                type: type,
              },
            });

            (async () => {
              while (
                await new Promise<boolean>((resolve) => {
                  setTimeout(() => {
                    this.sharedService
                      .checkPadding(response.padding)
                      .subscribe({
                        next: (check) => {
                          resolve(!check.status);
                          if (check.status) {
                            this.successModal(
                              'Le client a confirmer la vente. ✅'
                            );
                            m.destroy();
                          }
                        },
                        error: (error) => {
                          console.log(error);
                          resolve(false);
                        },
                      });
                  }, 500);
                })
              ) {
                console.log('Wait for check');
              }
            })();
          } else {
            this.notification.success(
              'Notification',
              'Commande est validé avec succès'
            );
          }
          this.location.back()
          this.isLoad = false;
        },
        error: (errors) => {
          this.notificatoinService.emitChange({
            title: 'Paiement annullé',
            message: errors.error.message,
            type: 'error',
          });
          this.isLoad = false;
          console.error(errors);
        },
      });
  }

  successModal(message: string) {
    this.modalService.create({
      nzTitle: undefined,
      nzFooter: null,
      nzContent: PayementPaddingComponent,
      nzCentered: true,
      nzMaskClosable: false,
      nzComponentParams: {
        text: message,
        type: 'success',
        load: false,
      },
    });
  }

  showModal() {
    this.isVisible = !this.isVisible;
  }
  displayModal() {
    this.isInvisible = !this.isInvisible;
  }

  toggleMobilePayementModal() {
    this.payementFormGroup.addControl(
      'telephone',
      new FormControl(this.selectedClient.telephone, [
        Validators.required,
        Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
      ])
    );
    this.makeVisible = !this.makeVisible;
  }

  selectCommission(data: any) {
    console.log('commission');
  }

  closePayementModal() {
    this.makeVisible = false;
  }
  onMobilePayementSelected(type: any) {
    this.closePayementModal();
    this.saveVente(this.payementType, type);
  }

  onPayementTypeSelected(name: string) {
    this.payementFormGroup = this.fb.group({
      firstPart: [null, [Validators.required, Validators.min(this.aPayer())]],
      interet: [null, [Validators.required]],
    });

    this.payementType = name;
    if (this.selectedClient) {
      if (name == 'offline') {
        this.localPayementVisible = true;
      } else if (name == 'online') {
        this.toggleMobilePayementModal();
      }
    }
  }
}
