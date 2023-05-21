import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AdminService } from 'src/app/services/admin.service';

@Component({
  selector: 'app-edit-admin',
  templateUrl: './edit-admin.component.html',
  styleUrls: ['./edit-admin.component.css']
})
export class EditAdminComponent {

  adminId: any;
  adminForm: FormGroup;

  constructor(private adminService: AdminService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router, private activatedRoute: ActivatedRoute) {
    this.adminId = this.activatedRoute.snapshot.paramMap.get('id'); // Get admin id from the URL param

    this.adminForm = this.formBuilder.group({
      nicNo: '',
      name: '',
      contactNo: '',
      userType: '',
      username: '',
      password: ''
    });

    // Get admin data though the API
    this.adminService.getAdmin(this.adminId).subscribe(res => {
      this.adminForm.setValue({
        nicNo: res['nicNo'],
        name: res['name'],
        contactNo: res['contactNo'],
        userType: res['type'],
        username: res['username'],
        password: ''
      });
    });
  }

  // Update admin
  updateAdmin(): any {
    this.adminService.updateAdmin(this.adminId, this.adminForm.value)
      .subscribe(() => {
        alert('Admin updated successfully!');
        this.ngZone.run(() => this.router.navigateByUrl('admins'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }

  // Delete admin
  deleteAdmin(adminId: any) {
    if (window.confirm('Are you sure you want to delete this?')) {
      this.adminService.deleteAdmin(adminId).subscribe((res) => {
        alert('Admin deleted successfully!');
        this.ngZone.run(() => this.router.navigateByUrl('admins'))
      })
    }
  }
}
