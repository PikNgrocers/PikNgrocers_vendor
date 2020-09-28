import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/screen/home.dart';
import 'package:pikngrocers_vendor/screen/landingpage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'pik_n_grocers_vendor',
      options: const FirebaseOptions(
          appId: '1:141689222091:android:b24a382213c3342db17c4e',
          apiKey: 'AIzaSyBwmf8weNbdh3VP3U2sl8BnMe0zMv9fs8g',
          messagingSenderId: '141689222091',
          projectId: 'pik-n-grocers-651d4'
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LandingPage(),
        '/home':(context) => Home(),
      },
    );
  }
}
