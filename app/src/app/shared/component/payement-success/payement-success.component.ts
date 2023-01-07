import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-payement-success',
  templateUrl: './payement-success.component.html',
  styleUrls: ['./payement-success.component.scss'],
})
export class PayementSuccessComponent implements OnInit {
  constructor(private route: ActivatedRoute, private router: Router) {}
  params: any;
  ngOnInit(): void {
    this.route.queryParams.subscribe((params: any) => {
      console.log(params);
      this.params = params;
    });
  }

  home() {
    this.router.navigate(['/auth']);
  }

  commande() {
    this.router.navigate(['/client/commandes/show/' + this.params.cdi])
  }
}
