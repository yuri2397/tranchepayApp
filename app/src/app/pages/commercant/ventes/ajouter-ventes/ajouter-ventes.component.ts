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
import { MatIconRegistry } from "@angular/material/icon";
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
  mystyle = { width: "200px", padding: "25px" };
  modePaiement = [{ type_paiement: "Paiement en ligne", image_src: "/assets/img/paycash.png" }, { type_paiement: "Paiement en caisse", image_src: "/assets/img/paymobile.png" }];
  choixModePaiement = [{ name: "Wave", choice_label: "Payer avec Wave", image_src: "/assets/img/nav-logo.png", padding: "p-3", margin_top: "0px" },
  { name: "Orange Money", choice_label: "Payer avec Orange Money", image_src: "/assets/img/orangemoney.png", padding: "5px", margin_top: "0px" },
  { name: "Free Money", choice_label: "Payer avec Free Money", image_src: "/assets/img/freemoney.png", padding: "5px", margin_top: "-6px" }
  ]

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
      "paycash",
      this.domSanitizer.bypassSecurityTrustResourceUrl("../assets/img/paycash.svg")
    );
    this.matIconRegistry.addSvgIcon(
      "payonline",
      this.domSanitizer.bypassSecurityTrustResourceUrl("../assets/img/payonline.svg")
    );
  }
  ngOnChanges(changes: SimpleChanges): void {
    console.log("something has changed", !this.validateForm.get('telephone')?.value);

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
      type: ['0', [Validators.required]],
      mode_paiement: [null, [Validators.required]],
      first_part: [
        null,
        [Validators.required, Validators.min(this.firstPart())],
      ],
    });
  }

  firstPart(): number {
    let amount = 0;
    this.produits.forEach((p) => {
      amount += p.prix_unitaire * p.quantite;
    });
    return amount;
  }

  addToList() {
    this.montantActuelTotal = 0;
    let p = new Produit();
    p.nom = this.validateForm.value.nom_produit;
    p.quantite = this.validateForm.value.quantite_produit;
    p.prix_unitaire = this.validateForm.value.prix_unitaire_produit;
    this.produits = [...this.produits, p];
    this.produits.forEach(element => {
      this.montantActuelTotal += element.prix_unitaire * element.quantite;
    });
    this.handleCancel();
    this.validateForm.reset();
  }

  removeProduit(data: Produit) {
    this.produits.splice(this.produits.indexOf(data), 1);
    this.produits = [...this.produits];
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

  saveVente() {
    this.isLoad = true;
    this.commercantService
      .createCommande(
        this.produits,
        this.validateFormClient.value.telephone,
        this.validateFormClient.value.mode_paiement,
        this.validateFormClient.value.first_part,
        this.validateFormClient.value.type
      )
      .subscribe({
        next: (response) => {
          this.notification.create('success', 'Message', response.message);
          this.produits = [...[]];
          this.validateFormClient.reset();
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

  makeModalVisible() {
    this.makeVisible = !this.makeVisible;
    this.isInvisible = !this.isInvisible;
    // console.log(" Utilisateur:", this.commercantService.getUser(), "numero: ", this.validateFormClient.get('telephone')?.value);
  }

  handleCancel() {
    if (this.isVisible == true) {
      this.isVisible = false;
      this.validateForm.reset();
    }
    if (this.isInvisible == true) {
      this.isInvisible = false;
      this.validateFormClient.reset();
    }
    if (this.makeVisible == true) {
      this.makeVisible = false;
      this.montantTotal = 0;
      this.validateFormClient.reset();
    }
  }
  logData(montant: any, type: any) {
    this.produits.forEach(element => {
      this.montantActuelTotal += element.prix_unitaire * element.quantite;
    });
    console.log("------------------\nvaleur entré: ", montant,
      "choix du paiement: ", type,
      "montant total: ", this.montantActuelTotal,
      "type du paiment: ", this.typePay, "\n------------------");
    this.makeVisible = !this.makeVisible;
  }
  showing() {

    console.log(this.montantActuelTotal);
  }
}