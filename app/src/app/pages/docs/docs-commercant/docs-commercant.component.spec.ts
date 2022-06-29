import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocsCommercantComponent } from './docs-commercant.component';

describe('DocsCommercantComponent', () => {
  let component: DocsCommercantComponent;
  let fixture: ComponentFixture<DocsCommercantComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DocsCommercantComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocsCommercantComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
