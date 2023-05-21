import { Component } from '@angular/core';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent {

  users: any = [];

  constructor(private userService: UserService) { }

  ngOnInit(): void {
    // Fetch users
    this.userService.getUsers().subscribe(res => {
      this.users = res;
    });
  }

}
