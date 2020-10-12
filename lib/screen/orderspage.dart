import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class OrdersPage extends StatelessWidget {
  final String userId;
  OrdersPage({this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8eff7),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database(uid: userId).showOrderData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var doc = snapshot.data.docs;
            if (doc.length == 0) {
              return Center(
                child: Text('No orders'),
              );
            } else {
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, i) {
                    List products = doc[i].data()['products'];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                          tileColor: doc[i].data()['OrderStatus'] == 'Waiting'
                              ? Colors.deepOrange
                              : doc[i].data()['OrderStatus'] == 'Accepted'
                                  ? Colors.blue
                                  : doc[i].data()['OrderStatus'] == 'Packed'
                                      ? Colors.green
                                      : Colors.white,
                          title: doc[i].data()['OrderStatus'] == 'Waiting'
                              ? Text(
                                  'Confirm Order',
                                  style: TextStyle(color: Colors.white),
                                )
                              : doc[i].data()['OrderStatus'] == 'Accepted'
                                  ? Text(
                                      'Pack This Order',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : doc[i].data()['OrderStatus'] == 'Packed'
                                      ? Text(
                                          'Order Picked By User',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          'Order Completed',
                                          style: TextStyle(color: Colors.green),
                                        ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.list,
                              color: doc[i].data()['OrderStatus'] == 'Cash Received' ? Colors.green : Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return OrderedProductListWid(
                                        doc: doc, i: i, products: products);
                                  });
                            },
                          ),
                          trailing: doc[i].data()['OrderStatus'] == 'Waiting'
                              ? FlatButton(
                                  onPressed: () {
                                    try {
                                      Database(uid: userId)
                                          .updateOrderStatusToAccepted(
                                              docId: doc[i].reference.id);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text('Confirm'),
                                  textColor: Colors.deepOrange,
                                  color: Colors.white,
                                )
                              : doc[i].data()['OrderStatus'] == 'Accepted'
                                  ? FlatButton(
                                      onPressed: () {
                                        try {
                                          Database().updateOrderStatusToPacked(
                                              docId: doc[i].reference.id);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text('Packed'),
                                      textColor: Colors.blue,
                                      color: Colors.white,
                                    )
                                  : doc[i].data()['OrderStatus'] == 'Packed'
                                      ? FlatButton(
                                          onPressed: () {
                                            try {
                                              Database(uid: userId)
                                                  .updateOrderStatusToCashReceived(
                                                      docId:
                                                          doc[i].reference.id);
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          child: Text('Cash Received'),
                                          textColor: Colors.green,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        )),
                    );
                  });
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OrderedProductListWid extends StatelessWidget {
  const OrderedProductListWid({
    Key key,
    @required this.i,
    @required this.doc,
    @required this.products,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> doc;
  final List products;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.9),
      appBar: AppBar(
        title: Text(
          'Order ID: #${doc[i].data()['OrderId']}',
          style: TextStyle(color: kOrderColor, fontSize: 13),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kOrderColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListTile(
                tileColor: Colors.white,
                title: Text(
                  '${products[i]['ProductName']}',
                  style: TextStyle(color: kOrderColor),
                ),
                trailing: Text(
                  'Qty: x${products[i]['Quantity']}',
                  style: TextStyle(color: kOrderColor),
                ),
              ),
            );
          }),
    );
  }
}
