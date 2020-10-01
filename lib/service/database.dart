import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  final String uid;

  Database({this.uid});

  FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');
  CollectionReference users =
      FirebaseFirestore.instanceFor(app: Firebase.app('pik_n_grocers_vendor'))
          .collection('user');

  Future<void> updateUserData(
      {String shopname, String fsno, String phno}) async {
    return await users
        .doc(uid)
        .set({
      'shop_name': shopname,
      'fs_no': fsno,
      'ph_no': phno,
    });
  }

  showProductData({String where}) {
    return users.doc(uid).collection('product').doc(where).collection('product_list').snapshots();
  }

  Future<void> addProduct(
      {String where,String proId, String proName, String proPrice, String proQuan}) async {
    return await users
        .doc(uid)
        .collection('product')
        .doc(where)
        .collection('product_list')
        .doc(proId)
        .set(
          {
              'Product_Id' : proId,
              'Product_Name': proName,
              'Product_Quantity': proQuan,
              'Price': int.parse(proPrice),
          },
        )
        .then((value) => print('added'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> removeProduct(
      {String where,String proId}) async {
    return await users
        .doc(uid)
        .collection('product')
        .doc(where)
        .collection('product_list')
        .doc(proId)
        .delete()
        .then((value) => print('deleted'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

}
