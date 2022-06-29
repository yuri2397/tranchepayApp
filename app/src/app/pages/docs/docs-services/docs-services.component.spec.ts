import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocsServicesComponent } from './docs-services.component';

describe('DocsServicesComponent', () => {
  let component: DocsServicesComponent;
  let fixture: ComponentFixture<DocsServicesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DocsServicesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocsServicesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
