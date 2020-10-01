import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/screen/dashboardpage.dart';
import 'package:pikngrocers_vendor/screen/offerspage.dart';
import 'package:pikngrocers_vendor/screen/orderspage.dart';
import 'package:pikngrocers_vendor/screen/productspage.dart';
import 'package:pikngrocers_vendor/screen/walletpage.dart';
import 'package:pikngrocers_vendor/service/auth.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _pageController = PageController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person_pin, color: Colors.black,),
        title: Text('Wel${widget.uid}', style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
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
          ProductsPage(uid: widget.uid),
          OrdersPage(),
          DashBoardPage(),
          OffersPage(),
          WalletPage(),
        ],
        onPageChanged: (page) {
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
            backgroundColor: kProductColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Orders'),
            backgroundColor: kOrderColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            backgroundColor: kDashBoardColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            title: Text('Offers'),
            backgroundColor: kOfferColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            backgroundColor: kWalletColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            print(index);
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
