import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HandleLocationPermissions {
  // Handle location permissions
  Future<bool> handleLocationPermissions(var context) async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Device location service is disabled. Please enable the service!'),
        ),
      );
      return false;
    }
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied!'),
          ),
        );
        return false;
      }
    }
    if (_permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device location service is permanently denied!'),
        ),
      );
      return false;
    }
    return true;
  }
}
