import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/constants.dart';
import 'package:pikngrocers_vendor/product_widget/no_product_to_display.dart';
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
                ? NoProductWidget()
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
  ShowProductList({this.snapshot, this.uid, this.where});

  final _offerPrice = TextEditingController();

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
                      doc[index].data()['Offer_price'] == null
                          ? Text(
                              'Price : ₹${doc[index].data()['Price'].toString()}',
                            )
                          : Column(
                              children: [
                                Text(
                                  'Price : ₹${doc[index].data()['Price'].toString()}',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  'Offer Price : ₹${doc[index].data()['Offer_price'].toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    doc[index].data()['Offer_price'] != null
                        ? removeOfferFlatButton(doc, index)
                        : addOfferFlatButton(context, doc, index),
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
                                    try {
                                      Database(uid: uid).removeProduct(
                                          where: where,
                                          proId: doc[index]
                                              .data()['Product_Id']
                                              .toString());
                                      Navigator.pop(context);
                                    } catch (e) {
                                      print('Cant Delete data');
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text('Delete'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  FlatButton addOfferFlatButton(
      BuildContext context, List<QueryDocumentSnapshot> doc, int index) {
    return FlatButton(
        onPressed: () {
          showDialog(
            context: context,
            child: AlertDialog(
              content: TextField(
                controller: _offerPrice,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Offer Price',
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    try {
                      Database(uid: uid).addOffer(
                        where: where,
                        proId: doc[index].data()['Product_Id'].toString(),
                        offerPrice: _offerPrice.text.trim(),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Add'),
                  textColor: Colors.white,
                  color: Colors.green,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  textColor: Colors.white,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        color: Colors.orangeAccent,
        child: Text(
          'Add Offers',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  FlatButton removeOfferFlatButton(List<QueryDocumentSnapshot> doc, int index) {
    return FlatButton(
      onPressed: () {
        try {
          Database(uid: uid).removeOffer(
            where: where,
            proId: doc[index].data()['Product_Id'].toString(),
          );
        } catch (e) {
          print(e);
        }
      },
      child: Text('Remove Offer'),
      textColor: Colors.white,
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
