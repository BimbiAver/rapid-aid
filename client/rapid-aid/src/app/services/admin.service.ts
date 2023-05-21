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

  // Add admin
  addAdmin(data: Admin): Observable<any> {
    let api = `${ADMIN_API}`;
    return this.http
      .post(api, data)
      .pipe(catchError(this.handleError));
  }

  // Update admin
  updateAdmin(adminId: any, data: any): Observable<any> {
    let api = `${ADMIN_API}/${adminId}`;
    return this.http
      .patch(api, data, { headers: this.headers })
      .pipe(catchError(this.handleError));
  }

  // Delete admin
  deleteAdmin(adminId: any): Observable<any> {
    let api = `${ADMIN_API}/${adminId}`;
    return this.http
      .delete(api, { headers: this.headers })
      .pipe(catchError(this.handleError));
  }

  // Error handling
  handleError(error: HttpErrorResponse) {
    let msg = '';
    msg = `Error Code: ${error.status}\nMessage: ${error.error.error}`;
    return throwError(alert(msg));
  }
}