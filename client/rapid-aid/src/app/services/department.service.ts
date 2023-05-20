import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

import { Department } from '../models/department.model';

const DEPARTMENT_API = 'https://rapidaid.live/api/departments';

@Injectable({
  providedIn: 'root'
})
export class DepartmentService {

  headers = new HttpHeaders().set('Content-Type', 'application/json');
  constructor(private http: HttpClient, public router: Router) { }

  // Get departments
  getDepartments() {
    return this.http.get(`${DEPARTMENT_API}`);
  }

  // Get department data
  getDepartment(departId: any): Observable<any> {
    let api = `${DEPARTMENT_API}/${departId}`;
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