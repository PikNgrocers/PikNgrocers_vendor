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

  CollectionReference vendorGps =
  FirebaseFirestore.instanceFor(app: Firebase.app('pik_n_grocers_vendor'))
      .collection('vendors_gps');

  final geo = Geoflutterfire();

  Future<void> updateUserData(
      {String shopname, String fsno, String phno,String username}) async {
    return await vendors
        .doc(uid)
        .set({
      'username' : username,
      'shop_name': shopname,
      'fs_no': fsno,
      'ph_no': phno,
    });
  }

  Future<void> vendorLocationData(
  {double lat,double lon,String shopName,String address}) async {
    GeoFirePoint location = geo.point(latitude: lat, longitude: lon);
    return await vendorGps.add({
      'vendor_id' : uid,
      'shop_name' : shopName,
      'address' : address,
      'position' : location.data,
    });
  }

  showProductData({String where,}) {
    return vendors.doc(uid).collection('product').doc(where).collection('product_list').snapshots();
  }

  Future<void> addProduct(
      {String where,String proId, String proName, String proPrice, String proQuan,String offerPrice}) async {
    return await vendors
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
              'Offer_price' : offerPrice == null ? null : int.parse(offerPrice),
          },
        )
        .then((value) => print('added'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }
  Future<void> addOffer(
      {String where,String proId,String offerPrice}) async {
    return await vendors
        .doc(uid)
        .collection('product')
        .doc(where)
        .collection('product_list')
        .doc(proId)
        .update(
      {
        'Offer_price' : offerPrice == null ? null : int.parse(offerPrice),
      },
    )
        .then((value) => print('updated'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> removeOffer(
      {String where,String proId}) async {
    return await vendors
        .doc(uid)
        .collection('product')
        .doc(where)
        .collection('product_list')
        .doc(proId)
        .update(
      {
        'Offer_price' : null,
      },
    )
        .then((value) => print('updated'))
        .catchError((onError) => print('Failed to catch error $onError'));
  }

  Future<void> removeProduct(
      {String where,String proId}) async {
    return await vendors
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
