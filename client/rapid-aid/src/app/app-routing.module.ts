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
import { EditDepartmentComponent } from './components/edit-department/edit-department.component';
import { EditStationComponent } from './components/edit-station/edit-station.component';
import { AddStationComponent } from './components/add-station/add-station.component';
import { EditAdminComponent } from './components/edit-admin/edit-admin.component';
import { CreateAdminComponent } from './components/create-admin/create-admin.component';
import { UsersComponent } from './components/users/users.component';
import { UserDetailsComponent } from './components/user-details/user-details.component';
import { CasesComponent } from './components/cases/cases.component';
import { ManageCaseComponent } from './components/manage-case/manage-case.component';

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
    canActivateChild: [AuthGuard],
    children: [
      { path: 'dashboard', component: DashboardComponent, title: 'Dashboard | RapidAid - Keep calm and trust us' },
      { path: 'profile', component: ProfileComponent, title: 'Profile | RapidAid - Keep calm and trust us' },
      { path: 'cases', component: CasesComponent, title: 'Cases | RapidAid - Keep calm and trust us' },
      { path: 'manage-case/:id', component: ManageCaseComponent, title: 'Manage Case | RapidAid - Keep calm and trust us' },
      { path: 'users', component: UsersComponent, title: 'Manage Users | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
      { path: 'user-details/:id', component: UserDetailsComponent, title: 'User Details | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
      { path: 'admins', component: AdminsComponent, title: 'Manage Admins | RapidAid - Keep calm and trust us', data: { role: 'Super Admin' } },
      { path: 'create-admin', component: CreateAdminComponent, title: 'Create Admin | RapidAid - Keep calm and trust us', data: { role: 'Super Admin' } },
      { path: 'edit-admin/:id', component: EditAdminComponent, title: 'Edit Admin | RapidAid - Keep calm and trust us', data: { role: 'Super Admin' } },
      { path: 'departments', component: DepartmentsComponent, title: 'Manage Departments | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
      { path: 'edit-department/:id', component: EditDepartmentComponent, title: 'Edit Department | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
      { path: 'stations', component: StationsComponent, title: 'Manage Stations | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin', 'Department'] } },
      { path: 'add-station', component: AddStationComponent, title: 'Add Station | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
      { path: 'edit-station/:id', component: EditStationComponent, title: 'Edit Station | RapidAid - Keep calm and trust us', data: { role: ['Super Admin', 'Local Admin'] } },
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
