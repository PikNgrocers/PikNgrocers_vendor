import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/screen/home.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
  final String uid;
  final String shopname;
  final String username;

  LocationScreen({this.uid, this.shopname, this.username});
}

class _LocationScreenState extends State<LocationScreen> {
  double lati, longi;

  Future<void> getPostion() async {
    bool locationService = await isLocationServiceEnabled();

    if (locationService) {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(
          position.latitude.toString() + '  ' + position.longitude.toString());
      lati = position.latitude;
      longi = position.longitude;
    } else {
      Fluttertoast.showToast(msg: 'Enable GPS');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostion(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something Went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GoogleMapShowTime(
            lat: lati,
            lon: longi,
            uid: widget.uid,
            shopname: widget.shopname,
            username: widget.username,
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

class GoogleMapShowTime extends StatefulWidget {
  GoogleMapShowTime(
      {this.lat, this.lon, this.uid, this.shopname, this.username});
  final String username;
  final double lat;
  final double lon;
  final String uid;
  final String shopname;

  @override
  _GoogleMapShowTimeState createState() => _GoogleMapShowTimeState();
}

class _GoogleMapShowTimeState extends State<GoogleMapShowTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: [
                Marker(
                  markerId: MarkerId('My sweet Home'),
                  position: LatLng(widget.lat, widget.lon),
                )
              ].toSet(),
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.lon), zoom: 18),
              mapType: MapType.normal,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Positioned(
                top: 25,
                right: 25,
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('SKIP'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Positioned(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'LATITUDE : ${widget.lat},\nLONGITUDE : ${widget.lon}',
                          style: TextStyle(color: kRegisterBackgroundColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () {
                            try {
                              Database(uid: widget.uid).vendorLocationData(
                                  shopName: widget.shopname,
                                  lat: widget.lat,
                                  lon: widget.lon);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(
                                      uid: widget.uid,
                                      username: widget.username,
                                    ),
                                  ),
                                  (Route<dynamic> route) => false);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('CONFIRM LOCATION'),
                          color: kRegisterBackgroundColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
