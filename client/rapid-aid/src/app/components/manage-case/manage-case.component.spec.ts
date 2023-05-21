import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageCaseComponent } from './manage-case.component';

describe('ManageCaseComponent', () => {
  let component: ManageCaseComponent;
  let fixture: ComponentFixture<ManageCaseComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageCaseComponent]
    });
    fixture = TestBed.createComponent(ManageCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
