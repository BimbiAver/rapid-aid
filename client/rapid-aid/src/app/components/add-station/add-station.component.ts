import { Component, NgZone } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { StationService } from 'src/app/services/station.service';

@Component({
  selector: 'app-add-station',
  templateUrl: './add-station.component.html',
  styleUrls: ['./add-station.component.css']
})
export class AddStationComponent {

  stationForm: FormGroup;

  constructor(private stationService: StationService, private formBuilder: FormBuilder, private ngZone: NgZone, private router: Router) {

    this.stationForm = this.formBuilder.group({
      name: '',
      department: '',
      inCharge: '',
      address: '',
      location: '',
      contactNo: '',
      username: '',
      password: ''
    })
  }

  // Add station
  addStation(): any {
    this.stationService.addStation(this.stationForm.value)
      .subscribe(() => {
        alert('Station added successfully!')
        this.ngZone.run(() => this.router.navigateByUrl('/stations'))
      }, (err) => {
        alert('Operation unsuccessful, please try again!')
      });
  }
}
