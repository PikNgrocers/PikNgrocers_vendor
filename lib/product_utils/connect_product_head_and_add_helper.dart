import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/product_utils/product_add_helper.dart';
import 'package:pikngrocers_vendor/product_utils/show_products.dart';

class ConnectHeadAndAddHelper extends StatelessWidget {
  ConnectHeadAndAddHelper({this.uid, this.text});
  final String uid;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlatButton.icon(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black54,
                context: context,
                child: AddProductScreen(
                  uid: uid,
                  where: text,
                ),
              );
            },
            textColor: Colors.grey,
            icon: Icon(Icons.add_circle_outline),
            label: Text('Add Product'),
          ),
          Expanded(
            child: ProductList(
              uid: uid,
              where: text,
            ),
          ),
        ],
      ),
    );
  }
}
