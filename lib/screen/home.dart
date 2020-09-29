import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/models/user_uid.dart';
import 'package:pikngrocers_vendor/screen/dashboardpage.dart';
import 'package:pikngrocers_vendor/screen/offerspage.dart';
import 'package:pikngrocers_vendor/screen/orderspage.dart';
import 'package:pikngrocers_vendor/screen/productspage.dart';
import 'package:pikngrocers_vendor/screen/walletpage.dart';
import 'package:pikngrocers_vendor/service/auth.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _pageController= PageController();

  String uid;

  void getUserUid() {
    FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');
    User result =  FirebaseAuth.instanceFor(app: secondaryApp).currentUser;
    var userUidC = UserUid(uid: result.uid);
    uid = userUidC.uid;
  }

  @override
  void initState() {
    getUserUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: Database(uid: uid).getDatas(),
        builder: (context,snapshot){
      if(snapshot.hasError){
        print('Something wrong');
      }
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        print(snapshot.data.data());
        return homeNavigator(context);
      }
      return Center(child: Text('Loading'));
    });
  }

  Scaffold homeNavigator(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: Icon(Icons.person_pin,color: Colors.black,),
      title: Text(uid,style: TextStyle(color: Colors.black),),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
          Auth().logout();
          Navigator.pushReplacementNamed(context, '/');
        },
          color: Colors.black,
          tooltip: 'Logout',
        )
      ],
    ),
    body: PageView(
      controller: _pageController,
      children: [
        ProductsPage(uid: uid,),
        OrdersPage(),
        DashBoardPage(),
        OffersPage(),
        WalletPage(),
      ],
      onPageChanged: (page){
        setState(() {
          _currentIndex = page;
        });
      },
    ),
    bottomNavigationBar: BottomNavigationBar(
      selectedFontSize: kLabelFontSize,
      iconSize: 15,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Product'),
          backgroundColor: Color(0xff349A05),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text('Orders'),
          backgroundColor: Color(0xff040263),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          backgroundColor: Color(0xff630263),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          title: Text('Offers'),
          backgroundColor: Color(0xffFC3204),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          title: Text('Wallet'),
          backgroundColor: Color(0xff700d0d),
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.jumpToPage(index);
      },
      currentIndex: _currentIndex,
    ),
  );
  }
}
