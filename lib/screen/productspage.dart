import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/models/category_types.dart';

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(itemCount: categoryTypes.length,itemBuilder: (context,index){
          return ListTile(
            title: Text(categoryTypes[index].categoryTitle),
          );
        }),
      ),
    );
  }
}
