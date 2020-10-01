import 'package:flutter/material.dart';
import 'package:pikngrocers_vendor/service/database.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({this.uid, this.where});

  final uid;
  final where;

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();

  final _productId = TextEditingController();

  final _productName = TextEditingController();

  final _productQuantity = TextEditingController();

  final _productPrice = TextEditingController();

  @override
  void dispose() {
    _productId.dispose();
    _productName.dispose();
    _productQuantity.dispose();
    _productPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * (95 / 100),
          padding: EdgeInsets.only(left: 10, bottom: 20, top: 10, right: 10),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter Product Details',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _productId,
                  textAlign: TextAlign.center,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Product Id';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Product Id',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _productName,
                  textAlign: TextAlign.center,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Product Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _productQuantity,
                  textAlign: TextAlign.center,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Product Quantity';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Product Quantity',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _productPrice,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val.isNotEmpty) {
                      try {
                        int one = int.parse(val);
                        print(one);
                      } on FormatException catch (e) {
                        return 'Price value should be Number';
                      }
                    }
                    if (val.isEmpty) {
                      return 'Enter Product Price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Product Price',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      try {
                        Database(uid: widget.uid).addProductGroceryStaples(
                          where: widget.where,
                          proId: _productId.text,
                          proName: _productName.text,
                          proPrice: _productPrice.text,
                          proQuan: _productQuantity.text,
                        );
                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Something went wrong $e');
                      }
                      _productId.clear();
                      _productName.clear();
                      _productQuantity.clear();
                      _productPrice.clear();
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar smallSnackBar() {
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Product Added'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }
}
