import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VersementCreateComponent } from './versement-create.component';

describe('VersementCreateComponent', () => {
  let component: VersementCreateComponent;
  let fixture: ComponentFixture<VersementCreateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VersementCreateComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(VersementCreateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
