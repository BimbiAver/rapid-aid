import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AdminService } from 'src/app/services/admin.service';

@Component({
  selector: 'app-create-admin',
  templateUrl: './create-admin.component.html',
  styleUrls: ['./create-admin.component.css']
})
export class CreateAdminComponent {

  adminForm: FormGroup;

  constructor(private adminService: AdminService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router) {

    this.adminForm = this.formBuilder.group({
      nicNo: '',
      name: '',
      contactNo: '',
      userType: '',
      username: '',
      password: ''
    });
  }

  // Create admin
  createAdmin(): any {
    this.adminService.addAdmin(this.adminForm.value)
      .subscribe(() => {
        alert('Admin created successfully!')
        this.ngZone.run(() => this.router.navigateByUrl('/admins'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }
}
