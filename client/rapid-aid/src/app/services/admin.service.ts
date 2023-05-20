import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

import { Admin } from '../models/admin.model';

const ADMIN_API = 'https://rapidaid.live/api/admins';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  headers = new HttpHeaders().set('Content-Type', 'application/json');
  constructor(private http: HttpClient, public router: Router) { }

  // Get admins
  getAdmins() {
    return this.http.get(`${ADMIN_API}`);
  }

  // Get admin data
  getAdmin(adminId: any): Observable<any> {
    let api = `${ADMIN_API}/${adminId}`;
    return this.http.get(api, { headers: this.headers }).pipe(
      map((res) => {
        return res || {};
      }),
      catchError(this.handleError)
    );
  }

  // Error handling
  handleError(error: HttpErrorResponse) {
    let msg = '';
    msg = `Error Code: ${error.status}\nMessage: ${error.error.error}`;
    return throwError(alert(msg));
  }
}