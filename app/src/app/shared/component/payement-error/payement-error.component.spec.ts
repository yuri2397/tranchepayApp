import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PayementErrorComponent } from './payement-error.component';

describe('PayementErrorComponent', () => {
  let component: PayementErrorComponent;
  let fixture: ComponentFixture<PayementErrorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PayementErrorComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PayementErrorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
