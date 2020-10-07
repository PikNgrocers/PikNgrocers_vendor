import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Database {
  final String uid;
  Database({this.uid});

  FirebaseApp secondaryApp = Firebase.app('pik_n_grocers_vendor');
  CollectionReference vendors =
      FirebaseFirestore.instanceFor(app: Firebase.app('pik_n_grocers_vendor'))
          .collection('vendors');

  CollectionReference products =
      FirebaseFirestore.instanceFor(app: Firebase.app('pik_n_grocers_vendor'))
          .collection('products');

  final geo = Geoflutterfire();

  Future<void> updateUserData(
      {String shopname, String fsno, String phno, String username}) async {
    return await vendors.doc(uid).set({
      'username': username,
      'shop_name': shopname,
      'fs_no': fsno,
      'ph_no': phno,
    });
  }

  Future<void> vendorLocationData(
      {double lat, double lon, String address}) async {
    GeoFirePoint location = geo.point(latitude: lat, longitude: lon);
    return await vendors.doc(uid).update({
      'vendor_id': uid,
      'address': address,
      'position': location.data,
    });
  }

  showProductData({
    String where,
  }) {
    return products
    .where('vendor_Id',isEqualTo: uid)
    .where('Product_category',isEqualTo: where).snapshots();
  }

  Future<void> addProduct(
      {String where,
      String proId,
      String proName,
      String proPrice,
      String proQuan,
      String offerPrice}) async {
    return await products
        .doc(proId)
        .set(
          {
            'vendor_Id': uid,
            'Product_Id': proId,
            'Product_Name': proName,
            'Product_category': where,
            'Product_Quantity': proQuan,
            'Price': int.parse(proPrice),
            'Offer_price': offerPrice == "" ? null : int.parse(offerPrice),
          },
        )
        .then((value) => print('added'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> addOffer({String proId, String offerPrice}) async {
    return await products
        .doc(proId)
        .update(
          {
            'Offer_price': offerPrice == null ? null : int.parse(offerPrice),
          },
        )
        .then((value) => print('updated'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> removeOffer({String proId}) async {
    return await products
        .doc(proId)
        .update(
          {
            'Offer_price': null,
          },
        )
        .then((value) => print('updated'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> removeProduct({String where, String proId}) async {
    return await products
        .doc(proId)
        .delete()
        .then((value) => print('deleted'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }
}
