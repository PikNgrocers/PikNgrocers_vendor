import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff28df99),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vendor Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kLoginPageColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/vendor_login.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: kLoginPageColor,
                      size: 15.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLoginPageColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLoginPageColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: kLoginPageColor,
                    ),
                  ),
                  cursorColor: kLoginPageColor,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(

                  obscureText: true,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kLoginPageColor,
                      size: 15.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLoginPageColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLoginPageColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: kLoginPageColor,
                    ),
                  ),
                  cursorColor: kLoginPageColor,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  color: kLoginPageColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
