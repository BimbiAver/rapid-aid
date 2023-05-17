import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { AdminService } from 'src/app/services/admin.service';
import { DepartmentService } from 'src/app/services/department.service';
import { StationService } from 'src/app/services/station.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {

  jwtPayload = JSON.parse(atob(localStorage.getItem('access_token')!.split('.')[1])); // Get values from the token payload

  userProfileForm: FormGroup;

  constructor(private adminService: AdminService, private departmentService: DepartmentService, private stationService: StationService, private formBuilder: FormBuilder) {

    this.userProfileForm = this.formBuilder.group({
      nicNo: '',
      name: '',
      department: '',
      category: '',
      inCharge: '',
      address: '',
      location: '',
      contactNo: '',
      type: ''
    })

    // Fetch user details
    if (this.jwtPayload.adminId) {
      // If the logged in user is an admin
      this.adminService.getAdmin(this.jwtPayload.adminId).subscribe(this.setValues);
    } else if (this.jwtPayload.departmentId) {
      // If the logged in user is a department
      this.departmentService.getDepartment(this.jwtPayload.departmentId).subscribe(this.setValues);
    } else {
      // If the logged in user is a station
      this.stationService.getStation(this.jwtPayload.stationId).subscribe(this.setValues);
    }

  }

  // Set values after fetching data
  setValues = (res: any) => this.userProfileForm.patchValue({
    nicNo: res['nicNo'],
    name: res['name'],
    department: this.jwtPayload.stationId != null ? res['department']['name'] : null,
    category: res['category'],
    inCharge: res['inCharge'],
    address: res['address'],
    location: res['location'],
    contactNo: res['contactNo'],
    type: res['type'],
  });

}
