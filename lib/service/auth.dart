import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/models/user_uid.dart';
import 'package:pikngrocers_vendor/screen/home.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class Auth {
  FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');
  UserUid _userUid;

  Future registerUserWithEmailAndPassword(
      {BuildContext context,
      String email,
      String password,
      String username,
      String shopname,
      String fsno,
      String phno}) async {
    try {
      final result = await FirebaseAuth.instanceFor(app: secondaryApp)
          .createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;
      user.updateProfile(displayName: username);
      if (user == null) {
        print('User is null');
      } else {
        _userUid = UserUid(uid: user.uid);
        await Database(uid: _userUid.uid).updateUserData(
          shopname: shopname,
          fsno: fsno,
          phno: phno,
          username: username,
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Home(uid: _userUid.uid,username: username,)),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginUserWithEmailAndPassword(
      {BuildContext context, String email, String password}) async {
    try {
      final result = await FirebaseAuth.instanceFor(app: secondaryApp)
          .signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;
      if (user == null) {
        print('No user found');
      } else {
        _userUid = UserUid(uid: user.uid);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Home(uid: _userUid.uid,username: user.displayName,)),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() {
    return FirebaseAuth.instanceFor(app: secondaryApp).signOut();
  }


  phoneAuth({String phoneNumber, BuildContext context}) async {
    TextEditingController _otpController = TextEditingController();
    await FirebaseAuth.instanceFor(app: secondaryApp).verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return OtpEnterScreen(
                otpController: _otpController,
                auth: FirebaseAuth.instanceFor(app: secondaryApp),
                verificationId: verificationId,
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

class OtpEnterScreen extends StatelessWidget {
  const OtpEnterScreen({
    Key key,
    @required TextEditingController otpController,
    @required FirebaseAuth auth,
    @required verificationId,
  })  : _otpController = otpController,
        _auth = auth,
        _verificationId = verificationId,
        super(key: key);

  final TextEditingController _otpController;
  final FirebaseAuth _auth;
  final String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kRegisterBackgroundColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/enter_otp.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kRegisterBackgroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'We have sent you an OTP for phone number verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextField(
                  controller: _otpController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'OTP Number',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kRegisterBackgroundColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kRegisterBackgroundColor),
                    ),
                  ),
                  style: TextStyle(
                      color: kRegisterBackgroundColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  cursorColor: kRegisterBackgroundColor,
                  cursorWidth: 5,
                ),
                RaisedButton(
                  onPressed: () async {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: _verificationId,
                        smsCode: _otpController.text);
                    final result = await _auth.signInWithCredential(credential);
                    if (result.user != null) {
                      print(result.user);
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      print("Error");
                    }
                  },
                  color: kRegisterBackgroundColor,
                  textColor: Colors.white,
                  child: Text('Verify OTP'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
