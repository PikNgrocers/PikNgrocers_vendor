import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/screen/home.dart';
import 'package:pikngrocers_vendor/screen/loginpage.dart';
import 'package:pikngrocers_vendor/utils/nointernet.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _result;

  void getConnection() async{
    _result = await Connectivity().checkConnectivity();
  }

  @override
  void initState() {
    getConnection();
    super.initState();
  }


  FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instanceFor(app: secondaryApp).authStateChanges(),
      builder: (context, snapshot ) {
        if (_result == ConnectivityResult.none) {
          return NoInternet();
        }
        if (snapshot.hasData && snapshot.data != null) {
          return Home();
        }
        return LoginPage();
      }
    );
  }
}
