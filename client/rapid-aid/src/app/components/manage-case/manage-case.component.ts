import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CaseService } from 'src/app/services/case.service';

@Component({
  selector: 'app-manage-case',
  templateUrl: './manage-case.component.html',
  styleUrls: ['./manage-case.component.css']
})
export class ManageCaseComponent {

  caseId: any;
  case: any = [];

  caseStatusForm: FormGroup;

  constructor(private caseService: CaseService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router, private activatedRoute: ActivatedRoute) {

    this.caseId = this.activatedRoute.snapshot.paramMap.get('id'); // Get case id from the URL param

    this.caseStatusForm = this.formBuilder.group({
      status: ''
    });

  }

  ngOnInit(): void {
    // Get case details
    this.caseService.getCase(this.caseId).subscribe(res => {
      this.case = res;
      // Set status value in dropdown
      this.caseStatusForm.setValue({
        status: res['status']
      });
    });
  }

  // Update case status
  updateCaseStatus(): any {
    this.caseService.updateCase(this.caseId, this.caseStatusForm.value)
      .subscribe(() => {
        alert('Case updated successfully!');
        this.ngZone.run(() => this.router.navigateByUrl('cases'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }
}
