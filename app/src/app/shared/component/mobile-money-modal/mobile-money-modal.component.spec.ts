import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MobileMoneyModalComponent } from './mobile-money-modal.component';

describe('MobileMoneyModalComponent', () => {
  let component: MobileMoneyModalComponent;
  let fixture: ComponentFixture<MobileMoneyModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MobileMoneyModalComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MobileMoneyModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
