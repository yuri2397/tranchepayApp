import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CommercantComponent } from './commercant.component';

describe('CommercantComponent', () => {
  let component: CommercantComponent;
  let fixture: ComponentFixture<CommercantComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CommercantComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CommercantComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
