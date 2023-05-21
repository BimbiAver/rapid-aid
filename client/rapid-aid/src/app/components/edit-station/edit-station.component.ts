import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { StationService } from 'src/app/services/station.service';

@Component({
  selector: 'app-edit-station',
  templateUrl: './edit-station.component.html',
  styleUrls: ['./edit-station.component.css']
})
export class EditStationComponent {

  stationId: any;
  stationForm: FormGroup;

  constructor(private stationService: StationService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router, private activatedRoute: ActivatedRoute) {
    this.stationId = this.activatedRoute.snapshot.paramMap.get('id'); // Get station id from the URL param

    this.stationForm = this.formBuilder.group({
      name: '',
      department: '',
      inCharge: '',
      address: '',
      location: '',
      contactNo: '',
      username: '',
      password: ''
    });

    // Get station data though the API
    this.stationService.getStation(this.stationId).subscribe(res => {
      this.stationForm.setValue({
        name: res['name'],
        department: res['department']['_id'],
        inCharge: res['inCharge'],
        address: res['address'],
        location: res['location'],
        contactNo: res['contactNo'],
        username: res['username'],
        password: ''
      });
    });
  }

  // Update station
  updateStation(): any {
    this.stationService.updateStation(this.stationId, this.stationForm.value)
      .subscribe(() => {
        alert('Station updated successfully!');
        this.ngZone.run(() => this.router.navigateByUrl('stations'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }
}
