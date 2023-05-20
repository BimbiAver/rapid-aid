import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthComponent } from './layouts/auth/auth.component';
import { LoginComponent } from './components/login/login.component';
import { Error404Component } from './pages/error404/error404.component';
import { MainComponent } from './layouts/main/main.component';
import { AuthGuard } from './helpers/auth.guard';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AdminsComponent } from './components/admins/admins.component';
import { DepartmentsComponent } from './components/departments/departments.component';
import { StationsComponent } from './components/stations/stations.component';

const routes: Routes = [
  {
    path: 'auth',
    component: AuthComponent,
    children: [
      { path: 'login', component: LoginComponent, title: 'Log In | RapidAid - Keep calm and trust us' },
      { path: '', redirectTo: "login", pathMatch: "full" },
      { path: '**', redirectTo: "login", pathMatch: "full" }
    ],
  },
  {
    path: '',
    component: MainComponent,
    canActivate: [AuthGuard],
    children: [
      { path: 'dashboard', component: DashboardComponent, title: 'Dashboard | RapidAid - Keep calm and trust us' },
      { path: 'profile', component: ProfileComponent, title: 'Profile | RapidAid - Keep calm and trust us' },
      { path: 'admins', component: AdminsComponent, title: 'Manage Admins | RapidAid - Keep calm and trust us' },
      { path: 'departments', component: DepartmentsComponent, title: 'Manage Departments | RapidAid - Keep calm and trust us' },
      { path: 'stations', component: StationsComponent, title: 'Manage Stations | RapidAid - Keep calm and trust us' },
      { path: '', redirectTo: "dashboard", pathMatch: "full" }
    ],
  },
  { path: '**', component: Error404Component, pathMatch: "full" }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { scrollPositionRestoration: 'enabled' })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
