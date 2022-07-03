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
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Client } from 'src/app/models/client';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
@Component({
  selector: 'app-ajouter-ventes',
  templateUrl: './ajouter-ventes.component.html',
  styleUrls: ['./ajouter-ventes.component.scss'],
})
export class AjouterVentesComponent implements OnInit {
  typePay!: string;
  validateForm!: FormGroup;
  montantTotal = 0;
  localPayementVisible = false;
  montantActuelTotal = 0;
  validateFormClient!: FormGroup;
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
  firstPart!: number;
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

  constructor(
    private domSanitizer: DomSanitizer,
    private matIconRegistry: MatIconRegistry,
    private fb: FormBuilder,
    private commercantService: CommercantService,
    private modalService: NzModalService,
    private notification: NzNotificationService,
    private sharedService: SharedService
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
  ngOnChanges(changes: SimpleChanges): void {
    console.log(
      'something has changed',
      !this.validateForm.get('telephone')?.value
    );
  }
  ngOnInit(): void {
    this.validateForm = this.fb.group({
      nom_produit: [null, [Validators.required]],
      quantite_produit: [null, [Validators.required, Validators.min(0)]],
      prix_unitaire_produit: [null, [Validators.required]],
    });

    this.validateFormClient = this.fb.group({
      telephone: [
        null,
        [Validators.required, Validators.minLength(9), Validators.minLength(9)],
      ],
      mode_paiement: [null, [Validators.required]],
    });
  }

  aPayer(): number {
    let amount = 0;
    this.produits.forEach((p) => {
      amount += p.prix_unitaire * p.quantite;
    });
    return amount - amount * (2 / 3);
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

  addClient() {
    let modal = this.modalService.create({
      nzTitle: 'Ajouter le client',
      nzContent: CreateClientComponent,
      nzFooter: null,
    });
    modal.afterClose.subscribe((data: Client | null) => {
      if (data) {
        this.validateFormClient.reset();
        this.validateForm.value.telephone = data.telephone;
      }
    });
  }

  clientChange(client: any) {
    if (client == null) return;
    this.selectedClient = client;

    this.modeLoad = true;
    this.sharedService.modePaiement(client).subscribe({
      next: (response) => {
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
    type: 'om' | 'wave' | 'free' | 'local' = 'local'
  ) {
    this.isLoad = true;
    console.log(
      this.produits,
      this.validateFormClient.value.telephone,
      mode,
      this.firstPart,
      this.validateFormClient.value.type,
      type
    );

    this.commercantService
      .createCommande(
        this.produits,
        this.validateFormClient.value.telephone,
        mode,
        this.firstPart,
        this.validateFormClient.value.type,
        type
      )
      .subscribe({
        next: (response) => {
          console.log(response);

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
              },
            });

            (async () => {
              while (
                await new Promise<boolean>((resolve) => {
                  setTimeout(() => {
                    this.sharedService.checkPadding(response.padding).subscribe({
                      next: (check) => {
                        console.log(check);
                        resolve(!check.status)
                      },
                      error: error => {
                        console.log(error);
                        resolve(false)
                      }
                    });
                  }, 500);
                })
              ) {
                console.log('Wait for check');
              }
            })()

          } else {
            this.notification.success(
              'Notification',
              'Commande est validé avec succès'
            );
          }

          this.produits = [];
          this.validateFormClient.reset();
          this.validateForm.reset();
          this.isLoad = false;
        },
        error: (errors) => {
          this.notification.create('error', 'Message', errors.error.message);
          this.isLoad = false;
          console.error(errors);
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
    this.makeVisible = !this.makeVisible;
  }

  closePayementModal() {
    this.makeVisible = false;
  }
  onMobilePayementSelected(type: any) {
    if (this.firstPart < this.aPayer()) {
      this.amountError = true;
      this.amountErrorMessage =
        'Montant minimum est de ' + this.aPayer() + ' FCFA';
      return;
    }
    this.closePayementModal();
    this.modalService.confirm({
      nzTitle: '<h3 class="text-danger">Attention!!!</h3>',
      nzContent: '<i>Vous etes sûr de vouloir continuer?</i>',
      nzCentered: true,
      nzOnOk: () =>
        this.saveVente(this.validateFormClient.value.mode_paiement, type),
    });
  }

  amountIsValide() {
    if (this.firstPart < this.aPayer()) return false;

    return true;
  }

  onPayementTypeSelected(name: string) {
    this.validateFormClient.value.type = name;

    if (this.selectedClient) {
      if (name == 'offline') {
        this.localPayementVisible = true;
      } else if (name == 'online') {
        this.toggleMobilePayementModal();
      }
    }
  }
}
