import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription, interval } from 'rxjs';
import { CaseService } from 'src/app/services/case.service';

@Component({
  selector: 'app-cases',
  templateUrl: './cases.component.html',
  styleUrls: ['./cases.component.css']
})
export class CasesComponent implements OnInit, OnDestroy {

  cases: any = [];
  private refreshSubscription: Subscription | undefined;

  constructor(private caseService: CaseService) { }

  ngOnInit(): void {
    // Fetch cases for the first time
    this.caseService.getCases().subscribe(res => {
      this.cases = res;
    });
    // Start the time to fetch cases for every 5 seconds
    this.startDataRefreshTimer();
  }

  ngOnDestroy(): void {
    this.stopDataRefreshTimer();
  }

  // Fetch cases for every 5 seconds
  private startDataRefreshTimer(): void {
    this.refreshSubscription = interval(5000).subscribe(() => {
      // Fetch cases
      this.fetchCases();
    });
  }

  private stopDataRefreshTimer(): void {
    if (this.refreshSubscription) {
      this.refreshSubscription.unsubscribe();
    }
  }

  private fetchCases(): void {
    // Fetch cases
    this.caseService.getCases().subscribe(res => {
      this.cases = res;
    });
  }

}
