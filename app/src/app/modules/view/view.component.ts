import {
  AfterViewInit,
  Component,
  OnInit,
  ElementRef,
  ViewChild,
} from '@angular/core';

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.scss'],
})
export class ViewComponent implements OnInit, AfterViewInit {
  @ViewChild('preloader') preloader!: ElementRef;

  currentYear : any;

  constructor() {}

  ngAfterViewInit(): void {
    window.onload = () => this.preloader.nativeElement.remove();
  }

  ngOnInit(): void {
    this.currentYear = new Date().getFullYear();
  }
}
