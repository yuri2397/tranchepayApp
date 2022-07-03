import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-payement-error',
  templateUrl: './payement-error.component.html',
  styleUrls: ['./payement-error.component.scss']
})
export class PayementErrorComponent implements OnInit {

  constructor(private route: ActivatedRoute, private router: Router) {}
  params: any;
  ngOnInit(): void {
    this.route.queryParams.subscribe((params) => {
      console.log(params);
      this.params = params;
    });
  }

  home() {
    this.router.navigate(['/']);
  }

  commande() {
    this.router.navigate(['/client/commandes/show/' + this.params.cdi])
  }

}
