import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/models/category_types.dart';
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
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Products',
              style: TextStyle(color: kProductColor),
            ),
            centerTitle: true,
            bottom: TabBar(
              labelColor: kProductColor,
              indicatorColor: kProductColor,
              isScrollable: true,
              tabs: categoryTypes
                  .map(
                    (e) => Tab(text: e.categoryTitle),
                  )
                  .toList(),
            ),
          ),
        ),
        body: TabBarView(
            children: categoryTypes
                .map((e) => ConnectHeadAndAddHelper(
                      uid: widget.uid,
                      text: e.categoryTitle,
                    ))
                .toList()),
      ),
    );
  }
}
