import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/service/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _shopName = TextEditingController();
  final _fssaiNumber= TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _shopName.dispose();
    _fssaiNumber.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRegisterBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kRegisterBackgroundColor,
        centerTitle: true,
        title: Text('Register',style: TextStyle(fontSize: 30,color: Colors.white ),),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (val){
                    if(val.isEmpty){
                      return "Enter UserName";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _name,
                  decoration: registerFieldDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val){
                    if(val.isEmpty){
                      return "Enter ShopName";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _shopName,
                  decoration: registerFieldDecoration(labelText: 'Shop Name'),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  validator: (val){
                    if(val.length < 14){
                      return "Enter a valid Fssai Number";
                    }
                    if(val.isEmpty){
                      return "Enter Fssai Number";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _fssaiNumber,
                  decoration: registerFieldDecoration(labelText: 'Fssai Number'),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (val){
                    if(val.length<10){
                      return "Enter a valid phone number";
                    }
                    if(val.isEmpty){
                      return "Enter Phone Number";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _phoneNumber,
                  decoration: registerFieldDecoration(labelText: 'Phone Number'),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (val){
                    if(val.isEmpty){
                      return "Enter Email Id";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _email,
                  decoration: registerFieldDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  validator: (val){
                    if(val.isEmpty){
                      return "Enter Password";
                    }
                    return null;
                  },
                  cursorColor: kRegisterBackgroundColor,
                  controller: _password,
                  decoration: registerFieldDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 10,),
                RaisedButton(onPressed: (){
                  if(_formKey.currentState.validate()){
                   try{
                     Auth().registerUserWithEmailAndPassword(
                       context: context,
                       email: _email.text,
                       username: _name.text,
                       shopname: _shopName.text,
                       fsno: _fssaiNumber.text,
                       password: _password.text,
                       phno: _phoneNumber.text,
                       );
                   }
                   catch(e){
                     print(e);
                   }
                  }
                },
                  child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                  color: kRegisterBackgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration registerFieldDecoration({String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: kRegisterBackgroundColor, fontSize: 20),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kRegisterBackgroundColor),
      ),
    );
  }
}
