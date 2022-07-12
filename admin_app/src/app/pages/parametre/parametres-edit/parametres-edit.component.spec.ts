import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParametresEditComponent } from './parametres-edit.component';

describe('ParametresEditComponent', () => {
  let component: ParametresEditComponent;
  let fixture: ComponentFixture<ParametresEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ParametresEditComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ParametresEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
