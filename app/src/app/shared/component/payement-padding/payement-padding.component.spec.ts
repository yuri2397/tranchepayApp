import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PayementPaddingComponent } from './payement-padding.component';

describe('PayementPaddingComponent', () => {
  let component: PayementPaddingComponent;
  let fixture: ComponentFixture<PayementPaddingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PayementPaddingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PayementPaddingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
