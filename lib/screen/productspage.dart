import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/product_utils/connect_product_head_and_add_helper.dart';

class ProductsPage extends StatefulWidget {
  final String uid;
  ProductsPage({this.uid});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                color: kProductColor,
                child: Center(
                  child: Text(
                    'PRODUCT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                color: Colors.white70,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Grocery & Staples',),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Snacks'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Breakfast & Dairy'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Beverages'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Household Care'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Personal Care'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Packaged Food'),
                    ConnectHeadAndAddHelper(uid: widget.uid,text: 'Fruits & Vegetables'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// try {
// Database(uid: widget.uid).addProductGroceryStaples();
// print('called');
// } catch(e) {
// print(e);
// }
