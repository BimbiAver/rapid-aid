import { Component } from '@angular/core';
import { DepartmentService } from 'src/app/services/department.service';

@Component({
  selector: 'app-departments',
  templateUrl: './departments.component.html',
  styleUrls: ['./departments.component.css']
})
export class DepartmentsComponent {

  departments: any = [];

  constructor(private departmentervice: DepartmentService) { }

  ngOnInit(): void {
    // Fetch departments
    this.departmentervice.getDepartments().subscribe(res => {
      this.departments = res;
    });
  }
}
