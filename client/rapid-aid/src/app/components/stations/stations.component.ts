import { Component } from '@angular/core';
import { StationService } from 'src/app/services/station.service';

@Component({
  selector: 'app-stations',
  templateUrl: './stations.component.html',
  styleUrls: ['./stations.component.css']
})
export class StationsComponent {

  jwtPayload = JSON.parse(atob(localStorage.getItem('access_token')!.split('.')[1])); // Get values from the token payload

  stations: any = [];

  constructor(private stationService: StationService) { }

  ngOnInit(): void {
    // Fetch admins
    this.stationService.getStations().subscribe(res => {
      this.stations = res;
    });
  }
}
