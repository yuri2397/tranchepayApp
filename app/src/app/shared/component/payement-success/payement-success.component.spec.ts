import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PayementSuccessComponent } from './payement-success.component';

describe('PayementSuccessComponent', () => {
  let component: PayementSuccessComponent;
  let fixture: ComponentFixture<PayementSuccessComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PayementSuccessComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PayementSuccessComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
