import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { DepartmentService } from 'src/app/services/department.service';

@Component({
  selector: 'app-edit-department',
  templateUrl: './edit-department.component.html',
  styleUrls: ['./edit-department.component.css']
})
export class EditDepartmentComponent {

  departmentId: any;
  departmentForm: FormGroup;

  constructor(private departmentService: DepartmentService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router, private activatedRoute: ActivatedRoute) {
    this.departmentId = this.activatedRoute.snapshot.paramMap.get('id'); // Get department id from the URL param

    this.departmentForm = this.formBuilder.group({
      name: '',
      category: '',
      inCharge: '',
      address: '',
      contactNo: '',
      username: '',
      password: ''
    });

    // Get department data though the API
    this.departmentService.getDepartment(this.departmentId).subscribe(res => {
      this.departmentForm.setValue({
        name: res['name'],
        category: res['category'],
        inCharge: res['inCharge'],
        address: res['address'],
        contactNo: res['contactNo'],
        username: res['username'],
        password: ''
      });
    });
  }

  // Update department
  updateDepartment(): any {
    this.departmentService.updateDepartment(this.departmentId, this.departmentForm.value)
      .subscribe(() => {
        alert('Department updated successfully!');
        this.ngZone.run(() => this.router.navigateByUrl('departments'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }

}
