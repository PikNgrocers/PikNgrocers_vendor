import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class ProductList extends StatelessWidget {
  final uid;
  final String where;
  ProductList({this.uid, this.where});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Database(uid: uid).showProductData(where: where),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error Occurs');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              value: 5,
              valueColor: AlwaysStoppedAnimation<Color>(kProductColor),
            ));
          }
          return Container(
            child: snapshot.data.docs.length == 0
                ? Center(
                    child: Text('Sorry Empty..'),
                  )
                : ShowProductList(
                    snapshot: snapshot,
              uid: uid,
              where: where,
                  ),
          );
        });
  }
}

class ShowProductList extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final uid;
  final where;
  ShowProductList({this.snapshot,this.uid,this.where});

  @override
  Widget build(BuildContext context) {
    var doc = snapshot.data.docs;
    return ListView.builder(
        itemCount: doc.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name : ${doc[index].data()['Product_Name'].toString()}',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Product ID : ${doc[index].data()['Product_Id'].toString()}',
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity : ${doc[index].data()['Product_Quantity'].toString()}',
                      ),
                      Text('Price : ₹${doc[index].data()['Price'].toString()}'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        color: Colors.orangeAccent,
                        child: Text(
                          'Add to Offers',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    FlatButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            barrierColor: Colors.black54,
                            context: context,
                            child: AlertDialog(
                              scrollable: false,
                              title: Column(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Are You Sure ?'),
                                ],
                              ),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      try{
                                        Database(uid:uid).removeProduct(where: where,proId: doc[index].data()['Product_Id'].toString());
                                        Navigator.pop(context);
                                      } catch(e){
                                        print('Cant Delete data');
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: Text('Delete'),),
                                SizedBox(height: 10,),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.grey,
                                  textColor: Colors.white,
                                  child: Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        color: Colors.redAccent,
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }
}

// snapshot.data.docs[0].data()['Price'].toString()
