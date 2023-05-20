import { Injectable } from '@angular/core';
import { throwError } from 'rxjs';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

import { Login } from '../models/login.model';
import { Admin } from '../models/admin.model';
import { Department } from '../models/department.model';
import { Station } from '../models/station.model';

const AUTH_API = 'https://rapidaid.live/api/auth/login';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  headers = new HttpHeaders().set('Content-Type', 'application/json');
  constructor(private http: HttpClient, public router: Router) { }

  // User login
  login(user: Login) {
    return this.http
      .post<any>(`${AUTH_API}`, user)
      .subscribe({
        next: res => {
          localStorage.setItem('access_token', res.token);
          this.router.navigate(['dashboard']);
        },
        error: error => alert(error.error.error)
      });
  }

  // Get the token via local storage getItem() method
  getToken() {
    return localStorage.getItem('access_token');
  }

  // Check whether the user is logged in or not
  get isLoggedIn(): boolean {
    let authToken = localStorage.getItem('access_token');
    return authToken !== null ? true : false;
  }

  // User logout
  logout() {
    let removeToken = localStorage.removeItem('access_token');
    if (removeToken == null) {
      this.router.navigate(['auth/login']);
    }
  }

  // Error handling
  handleError(error: HttpErrorResponse) {
    let msg = '';
    msg = `Error Code: ${error.status}\nMessage: ${error.error.error}`;
    return throwError(alert(msg));
  }
}
