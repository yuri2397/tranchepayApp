import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PartenaireEditComponent } from './partenaire-edit.component';

describe('PartenaireEditComponent', () => {
  let component: PartenaireEditComponent;
  let fixture: ComponentFixture<PartenaireEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PartenaireEditComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PartenaireEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
