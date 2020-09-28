import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/signal_searching.png'),
            SizedBox(height: 20,),
            Text('No Network Check Your Connection and Click refresh Button Below',textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            RaisedButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/nettest');
            },
            child: Text('Refresh'),)
          ],
        ),
      ),
    );
  }
}
