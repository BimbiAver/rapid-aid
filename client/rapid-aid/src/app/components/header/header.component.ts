import { Component } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent {

  jwtPayload = JSON.parse(atob(localStorage.getItem('access_token')!.split('.')[1])); // Get values from the token payload

  constructor(private authService: AuthService) { }

  // User logout
  userLogout() {
    this.authService.logout();
  }

}
