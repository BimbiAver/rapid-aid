import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, catchError, map, throwError } from 'rxjs';

const CASE_API = 'https://rapidaid.live/api/cases';

@Injectable({
  providedIn: 'root'
})
export class CaseService {

  headers = new HttpHeaders().set('Content-Type', 'application/json');
  constructor(private http: HttpClient, public router: Router) { }

  // Get cases
  getCases() {
    return this.http.get(`${CASE_API}`);
  }

  // Get case data
  getCase(caseId: any): Observable<any> {
    let api = `${CASE_API}/${caseId}`;
    return this.http.get(api, { headers: this.headers }).pipe(
      map((res) => {
        return res || {};
      }),
      catchError(this.handleError)
    );
  }

  // Update case
  updateCase(caseId: any, data: any): Observable<any> {
    let api = `${CASE_API}/${caseId}`;
    return this.http
      .patch(api, data, { headers: this.headers })
      .pipe(catchError(this.handleError));
  }

  // Error handling
  handleError(error: HttpErrorResponse) {
    let msg = '';
    msg = `Error Code: ${error.status}\nMessage: ${error.error.error}`;
    return throwError(alert(msg));
  }
}
