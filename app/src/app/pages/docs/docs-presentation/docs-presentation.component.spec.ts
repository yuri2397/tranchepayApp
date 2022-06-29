import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocsPresentationComponent } from './docs-presentation.component';

describe('DocsPresentationComponent', () => {
  let component: DocsPresentationComponent;
  let fixture: ComponentFixture<DocsPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DocsPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocsPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
