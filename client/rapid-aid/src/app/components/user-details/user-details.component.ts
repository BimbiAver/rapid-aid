import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-details',
  templateUrl: './user-details.component.html',
  styleUrls: ['./user-details.component.css']
})
export class UserDetailsComponent {

  userId: any;
  user: any = [];
  dob: String | undefined;

  constructor(private userService: UserService, private activatedRoute: ActivatedRoute) {

    this.userId = this.activatedRoute.snapshot.paramMap.get('id'); // Get user id from the URL param

  }

  ngOnInit(): void {
    // Get user details
    this.userService.getUser(this.userId).subscribe(res => {
      this.user = res;
      this.dob = this.user.dob.substring(0, this.user.dob.indexOf('T'))
    });
  }

}
