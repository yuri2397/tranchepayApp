import { ClientService } from 'src/app/services/client.service'
import { ActivatedRoute } from '@angular/router'
import { PayementPaddingComponent } from './../../../../shared/component/payement-padding/payement-padding.component'
import { ModePaiement } from './../../../../models/mode-paiement'
import { SharedService } from './../../../../services/shared.service'
import { NzNotificationService } from 'ng-zorro-antd/notification'
import { NzModalService } from 'ng-zorro-antd/modal'
import { CommercantService } from './../../../../services/commercant.service'
import { Produit } from './../../../../models/produit'
import { Component, OnInit } from '@angular/core'
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms'
import { Client } from 'src/app/models/client'
import { MatIconRegistry } from '@angular/material/icon'
import { DomSanitizer } from '@angular/platform-browser'
import { NotificationService } from 'src/app/shared/notification.service'
import { Location } from '@angular/common'
@Component({
  selector: 'app-ajouter-ventes',
  templateUrl: './ajouter-ventes.component.html',
  styleUrls: ['./ajouter-ventes.component.scss'],
})
export class AjouterVentesComponent implements OnInit {
  typePay!: string
  validateForm!: FormGroup
  payementFormGroup!: FormGroup
  montantTotal = 0
  localPayementVisible = false
  montantActuelTotal = 0

  isLoad: boolean = false
  produits: Produit[] = []
  clients: Client[] = []
  selectedClient!: Client
  modePaiements!: ModePaiement[]
  loadClient = false
  drawerVisible = false
  modeLoad: boolean = false
  isVisible = false
  isInvisible = false
  makeVisible = false
  selectModeError = false
  selectProductError = false
  mystyle = {
    width: '200px',
    padding: '0px',
  }

  paiementTypes = [
    {
      name: 'offline',
      choice_label: 'Payer en caisse',
      image_src: '/assets/img/wave.png',
      padding: '5px',
      margin_top: '-6px',
      type_paiement: 'offline',
    },
    {
      name: 'wave',
      choice_label: 'Payer avec Wave',
      image_src: '/assets/img/nav-logo.png',
      padding: 'p-3',
      margin_top: '0px',
      type_paiement: 'online',
    },
    {
      name: 'om',
      choice_label: 'Payer avec Orange Money',
      image_src: '/assets/img/orangemoney.png',
      padding: '5px',
      margin_top: '0px',
      type_paiement: 'online',
    },
    {
      name: 'free',
      choice_label: 'Payer avec Free Money',
      image_src: '/assets/img/freemoney.png',
      padding: '5px',
      margin_top: '-6px',
      type_paiement: 'online',
    },
  ]
  amountError: boolean = false
  amountErrorMessage!: string
  selectedInteret!: any
  commission: any = 0
  clientLoad!: boolean
  searchClientValue!: string
  produitsError!: string
  clientError!: string
  paymentError!: string

  constructor(
    private fb: FormBuilder,
    private commercantService: CommercantService,
    private modalService: NzModalService,
    private notification: NzNotificationService,
    private sharedService: SharedService,
    private route: ActivatedRoute,
    private notificatoinService: NotificationService,
    private location: Location,
    private clientService: ClientService,
  ) {}

  ngOnInit(): void {
    // this.route.queryParams.subscribe((params: any) => {
    //   this.selectedClient = JSON.parse(params['customer']) as Client
    //   this.getModePayement(this.selectedClient.id)
    // })

    this.payementFormGroup = this.fb.group({
      firstPart: [null, [Validators.required, Validators.min(this.aPayer())]],
      telephone: [null, [Validators.required]],
      payementType: [null, [Validators.required]],
    })

    this.validateForm = this.fb.group({
      nom_produit: [null, [Validators.required]],
      quantite_produit: [null, [Validators.required, Validators.min(0)]],
      prix_unitaire_produit: [null, [Validators.required]],
    })
  }

  clientSelected(telephone: any) {
    if (telephone && this.clients) {
      this.selectedClient = this.clients?.find(
        (e) => e.telephone == telephone,
      ) as Client
      console.log(this.selectedClient)
      if (this.selectedClient) {
        this.getModePayement(this.selectedClient.id)
      }
      this.clients = []
    }
    this.reset()
  }

  aPayer(): number {
    let amount = 0
    this.produits.forEach((p) => {
      amount += p.prix_unitaire * p.quantite
    })
    return Math.round(amount * (1 / 3))
  }

  addToList() {
    this.montantActuelTotal = 0
    let p = new Produit()
    p.nom = this.validateForm.value.nom_produit
    p.quantite = this.validateForm.value.quantite_produit
    p.prix_unitaire = this.validateForm.value.prix_unitaire_produit
    this.produits = [...this.produits, p]
    this.produits.forEach((element) => {
      this.montantActuelTotal += element.prix_unitaire * element.quantite
    })
    this.selectProductError = false
    this.validateForm.reset()
    this.reset()
  }

  removeProduit(data: Produit) {
    this.produits.splice(this.produits.indexOf(data), 1)

    this.produits = [...this.produits]
    this.reset()
  }

  total() {
    let amount = 0
    this.produits?.forEach((p) => (amount += p.prix_unitaire * p.quantite))
    return amount
  }

  getModePayement(client: any) {
    if (client == null) return

    this.modeLoad = true
    this.sharedService.modePaiement(client).subscribe({
      next: (response: any) => {
        console.log(response)
        this.modePaiements = response
        this.reset()

        this.modeLoad = false
      },
      error: (errors: any) => {
        console.log(errors)
      },
    })
  }

  onModeChange(data: any) {
    this.selectModeError = false
    this.selectCommission(data)
    this.reset()
  }

  saveVente(
    mode: 'online' | 'offline' | string,
    via: 'om' | 'wave' | 'free' | 'local' | string,
  ) {
    this.selectModeError = false

    this.valideData()

    if (
      !this.selectProductError &&
      !this.selectModeError &&
      this.payementFormGroup.valid
    ) {
      this.isLoad = true

      console.log(
        this.selectedClient,
        this.produits,
        this.payementFormGroup.value,
        mode,
        via,
      )

      this.commercantService
        .createCommande(
          this.produits,
          this.selectedClient.id,
          this.payementFormGroup.value.payementType,
          this.payementFormGroup.value.firstPart,
          this.payementFormGroup.value.telephone,
          mode,
          via,
        )
        .subscribe({
          next: (response: any) => {
            console.log(response)
            let type: any = 'info'
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
                  url: response.data?.wave_launch_url ?? null,
                  load: true,
                  type: type,
                },
              })

              ;(async () => {
                while (
                  await new Promise<boolean>((resolve) => {
                    setTimeout(() => {
                      this.sharedService
                        .checkPadding(response.padding)
                        .subscribe({
                          next: (check:any) => {
                            if (check.status) {
                              this.successModal(
                                'Le client a confirmer la vente. ✅',
                              )
                              m.destroy()
                            }
                            resolve(!check.status)
                          },
                          error: (error: any) => {
                            console.log(error)
                            m.destroy()
                            this.errorModal(error.error.message)
                            resolve(false)
                          },
                        })
                    }, 5000)
                  })
                ) {
                  console.log('Wait for check')
                }
              })()
            } else {
              this.notification.success(
                'Notification',
                'Commande est validé avec succès',
              )
              this.location.back()
              this.isLoad = false
            }
          },
          error: (errors: any) => {
            this.notificatoinService.emitChange({
              title: 'Paiement annullé',
              message: errors.error.message,
              type: 'error',
            })
            this.isLoad = false
            console.error(errors)
          },
        })
    }
  }
  valideData() {
    this.reset()
    if (!this.produits.length) {
      this.selectProductError = true
      this.produitsError = 'Ajouter un produit'
    }

    if (!this.selectedClient) {
      this.clientError = 'Rechercher et selected un client'
    }

    if (!this.payementFormGroup.valid) {
      this.paymentError = 'Veuillez remplir ces informations.'
    }
  }
  reset() {
    this.produitsError = ''
    this.clientError = ''
    this.paymentError = ''
  }

  successModal(message: string) {
    this.modalService
      .create({
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
      })
      .afterClose.subscribe((_: any) => {
        this.location.back()
      })
  }

  errorModal(message: string) {
    this.modalService.create({
      nzTitle: undefined,
      nzFooter: null,
      nzContent: PayementPaddingComponent,
      nzCentered: true,
      nzMaskClosable: false,
      nzClosable: true,
      nzComponentParams: {
        text: message,
        type: 'error',
        load: false,
      },
    })
  }

  showModal() {
    this.isVisible = !this.isVisible
  }
  displayModal() {
    this.isInvisible = !this.isInvisible
  }

  toggleMobilePayementModal() {
    this.payementFormGroup.addControl(
      'telephone',
      new FormControl(this.selectedClient.telephone, [
        Validators.required,
        Validators.pattern('^(77|78|75|70|76)[0-9]{7}$'),
      ]),
    )
    this.makeVisible = !this.makeVisible
  }

  selectCommission(data: any) {
    let mode = this.modePaiements.find((com) => com.id == data)
    if (mode) {
      this.commission = this.total() * (mode.interet / 100)
    }
  }

  search(event: Event) {
    const data = (event.target as HTMLInputElement).value
    if (data) {
      this.clientLoad = true
      this.clientService.search(data).subscribe({
        next: (response: any) => {
          console.log(response)
          this.clients = response
          this.clientLoad = false
        },
      })
    }
  }
}
