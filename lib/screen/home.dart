import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/screen/dashboardpage.dart';
import 'package:pikngrocers_vendor/screen/orderspage.dart';
import 'package:pikngrocers_vendor/screen/productspage.dart';
import 'package:pikngrocers_vendor/screen/walletpage.dart';
import 'package:pikngrocers_vendor/service/auth.dart';

class Home extends StatefulWidget {
  final String uid;
  final String username;
  Home({this.uid, this.username});

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
        leading: Icon(
          Icons.person_pin,
          color: Colors.grey,
        ),
        title: Text(
          'Welcome ${widget.username}',
          style: TextStyle(color: Colors.grey),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Auth().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            color: Colors.grey,
            tooltip: 'Logout',
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          ProductsPage(uid: widget.uid),
          OrdersPage(
            userId: widget.uid,
          ),
          DashBoardPage(),
          WalletPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: kLabelFontSize,
        iconSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
            backgroundColor: kProductColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Orders',
            backgroundColor: kOrderColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: kDashBoardColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
            backgroundColor: kWalletColor,
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
