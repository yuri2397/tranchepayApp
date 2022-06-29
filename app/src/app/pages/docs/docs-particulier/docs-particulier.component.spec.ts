import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocsParticulierComponent } from './docs-particulier.component';

describe('DocsParticulierComponent', () => {
  let component: DocsParticulierComponent;
  let fixture: ComponentFixture<DocsParticulierComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DocsParticulierComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocsParticulierComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
