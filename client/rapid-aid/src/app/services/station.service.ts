import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

import { Station } from '../models/station.model';

const STATION_API = 'https://rapidaid.live/api/stations';

@Injectable({
  providedIn: 'root'
})
export class StationService {

  headers = new HttpHeaders().set('Content-Type', 'application/json');
  constructor(private http: HttpClient, public router: Router) { }

  // Get stations
  getStations() {
    return this.http.get(`${STATION_API}`);
  }

  // Get station data
  getStation(stationId: any): Observable<any> {
    let api = `${STATION_API}/${stationId}`;
    return this.http.get(api, { headers: this.headers }).pipe(
      map((res) => {
        return res || {};
      }),
      catchError(this.handleError)
    );
  }

  // Add station
  addStation(data: Station): Observable<any> {
    let api = `${STATION_API}`;
    return this.http
      .post(api, data)
      .pipe(catchError(this.handleError));
  }

  // Update station
  updateStation(stationId: any, data: any): Observable<any> {
    let api = `${STATION_API}/${stationId}`;
    return this.http
      .patch(api, data, { headers: this.headers })
      .pipe(catchError(this.handleError));
  }

  // Delete station
  deleteStation(stationId: any): Observable<any> {
    let api = `${STATION_API}/${stationId}`;
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