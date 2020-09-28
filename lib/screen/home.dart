import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/screen/dashboardpage.dart';
import 'package:pikngrocers_vendor/screen/offerspage.dart';
import 'package:pikngrocers_vendor/screen/orderspage.dart';
import 'package:pikngrocers_vendor/screen/productspage.dart';
import 'package:pikngrocers_vendor/screen/walletpage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _pageController= PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ProductsPage(),
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
            backgroundColor: Color(0xff7268A6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Orders'),
            backgroundColor: Color(0xff7268A6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            backgroundColor: Color(0xff7268A6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            title: Text('Offers'),
            backgroundColor: Color(0xff7268A6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            backgroundColor: Color(0xff7268A6),
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
