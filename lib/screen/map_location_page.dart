import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pikngrocers_vendor/map_model/map_show.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
  final String uid;
  final String shopname;
  final String username;

  LocationScreen({this.uid, this.shopname, this.username});
}

class _LocationScreenState extends State<LocationScreen> {
  LatLng _markerLocation;
  LatLng _userLocation;
  Future<LocationData> _getUserLocation;


  Future<LocationData> getUserLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final result = await location.getLocation();
    _userLocation = LatLng(result.latitude, result.longitude);
    return result;
  }


  @override
  void initState() {
    super.initState();
    _getUserLocation = getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData>(
      future: _getUserLocation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GoogleMapShowTime(
            onTap: (location) async {
              setState((){
                _markerLocation = location;
              });
            },
            uid: widget.uid,
            shopname: widget.shopname,
            username: widget.username,
            markerLocation: _markerLocation,
            userLocation: _userLocation,
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              value: 5,
            ),
          ),
        );
      },
    );
  }
}
