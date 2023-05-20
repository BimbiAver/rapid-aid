import { Component } from '@angular/core';
import { AdminService } from 'src/app/services/admin.service';

@Component({
  selector: 'app-admins',
  templateUrl: './admins.component.html',
  styleUrls: ['./admins.component.css']
})
export class AdminsComponent {

  admins: any = [];

  constructor(private adminService: AdminService) { }

  ngOnInit(): void {
    // Fetch admins
    this.adminService.getAdmins().subscribe(res => {
      this.admins = res;
    });
  }
}
