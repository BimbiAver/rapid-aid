import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree, Router, CanActivateChild } from '@angular/router';
import { Observable } from 'rxjs';

import { AuthService } from '../services/auth.service';

@Injectable({
    providedIn: 'root'
})
export class AuthGuard implements CanActivate, CanActivateChild {

    constructor(public authService: AuthService, public router: Router) { }
    canActivate(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
        const accessToken = localStorage.getItem('access_token');
        const jwtPayload = accessToken != null ? JSON.parse(atob(accessToken!.split('.')[1])) : null; // Get values from the token payload
        if (this.authService.isLoggedIn !== true) {
            this.router.navigate(['auth/login'])
        }
        return true;
    }
    canActivateChild(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
        const accessToken = localStorage.getItem('access_token');
        const jwtPayload = accessToken != null ? JSON.parse(atob(accessToken!.split('.')[1])) : null; // Get values from the token payload
        // Check if the user logged-in or not
        if (this.authService.isLoggedIn) {
            // User authorization
            if (route.data['role'] && route.data['role'].indexOf(jwtPayload.role) === -1) {
                this.router.navigate(['dashboard']);
                return false;
            }
            return true;
        }
        this.router.navigate(['auth/login']);
        return false;
    }
}