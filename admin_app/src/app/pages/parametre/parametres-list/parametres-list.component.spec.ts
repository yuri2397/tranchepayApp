import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParametresListComponent } from './parametres-list.component';

describe('ParametresListComponent', () => {
  let component: ParametresListComponent;
  let fixture: ComponentFixture<ParametresListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ParametresListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ParametresListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
