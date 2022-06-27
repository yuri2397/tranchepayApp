import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConfirmePayementComponent } from './confirme-payement.component';

describe('ConfirmePayementComponent', () => {
  let component: ConfirmePayementComponent;
  let fixture: ComponentFixture<ConfirmePayementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ConfirmePayementComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ConfirmePayementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
