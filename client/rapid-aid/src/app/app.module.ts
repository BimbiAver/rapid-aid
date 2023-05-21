import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AuthComponent } from './layouts/auth/auth.component';
import { LoginComponent } from './components/login/login.component';
import { Error404Component } from './pages/error404/error404.component';
import { AuthInterceptor } from './helpers/auth.interceptor';
import { MainComponent } from './layouts/main/main.component';
import { FooterComponent } from './components/footer/footer.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { HeaderComponent } from './components/header/header.component';
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
import { UtcToLocalPipe } from './helpers/utc-to-local.pipe';

@NgModule({
  declarations: [
    AppComponent,
    AuthComponent,
    LoginComponent,
    Error404Component,
    MainComponent,
    FooterComponent,
    DashboardComponent,
    HeaderComponent,
    ProfileComponent,
    AdminsComponent,
    DepartmentsComponent,
    StationsComponent,
    EditDepartmentComponent,
    EditStationComponent,
    AddStationComponent,
    EditAdminComponent,
    CreateAdminComponent,
    UsersComponent,
    UserDetailsComponent,
    CasesComponent,
    UtcToLocalPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    FormsModule
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
