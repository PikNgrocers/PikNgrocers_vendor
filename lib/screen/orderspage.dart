import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class OrdersPage extends StatelessWidget {
  final String userId;
  OrdersPage({this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8eff7),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database().showOrderData(userId),
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
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
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
                        trailing: doc[i].data()['OrderStatus'] == 'Waiting'
                            ? FlatButton(
                                onPressed: () {
                                  try {
                                    Database().updateOrderStatusToAccepted(
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
                                        Database()
                                            .updateOrderStatusToCashReceived(
                                                docId: doc[i].reference.id);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text('Cash Received'),
                                    textColor: Colors.green,
                                    color: Colors.white,
                                  ) : Icon(Icons.done,color: Colors.green,)
                      ),
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
